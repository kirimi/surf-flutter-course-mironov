import 'package:flutter/material.dart';

/// Виджет загружает и показывает изображение из сети по адресу [url].
///
/// Во время загрузки вместо изображения показывает спиннер.
class NetworkImageWithSpinner extends StatelessWidget {
  final String url;
  final BoxFit fit;

  const NetworkImageWithSpinner({
    Key key,
    @required this.url,
    this.fit = BoxFit.cover,
  })  : assert(url != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: fit,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: const Duration(seconds: 1),
          curve: Curves.easeOut,
          child: child,
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        Widget loading;
        if (loadingProgress != null) {
          // в документации expectedTotalBytes может быть null
          // поэтому в этом кейсе показываем простую крутилку
          if (loadingProgress.expectedTotalBytes == null ||
              loadingProgress.expectedTotalBytes == 0) {
            loading = const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // Вычисляем прогресс для спиннера
            final progress = loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes;
            loading = Center(
              child: CircularProgressIndicator(value: progress),
            );
          }
        }
        return Stack(
          fit: StackFit.expand,
          children: [
            child,
            if (loading != null) loading,
          ],
        );
      },
    );
  }
}

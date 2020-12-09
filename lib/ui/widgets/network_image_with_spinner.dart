import 'package:flutter/material.dart';

class NetworkImageWithSpinner extends StatelessWidget {
  final String url;
  final BoxFit fit;

  const NetworkImageWithSpinner({
    Key key,
    this.url,
    this.fit = BoxFit.cover,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          // загрузка завершена, показываем картинку
          return child;
        } else {
          // в документации expectedTotalBytes может быть null поэтому в этом кейсе показываем простую крутилку
          if (loadingProgress.expectedTotalBytes == null || loadingProgress.expectedTotalBytes == 0) {
            return CircularProgressIndicator();
          }

          // Вычисляем прогресс для спиннера
          final progress = loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes;
          return Center(
            child: CircularProgressIndicator(value: progress),
          );
        }
      },
    );
  }
}

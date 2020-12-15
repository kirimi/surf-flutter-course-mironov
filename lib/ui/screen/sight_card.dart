import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/widgets/network_image_with_spinner.dart';

/// Карточка "Интересного места" для списка мест
///
/// Используется в списке мест на странице [SightListScreen]
class SightCard extends StatelessWidget {
  final Sight sight;

  const SightCard({Key key, this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(16.0)),
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    child: NetworkImageWithSpinner(url: sight.url),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          sight.type,
                          style: AppTextStyles.sightCardType.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.favorite_outline,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sight.name,
                        maxLines: 2,
                        style: AppTextStyles.sightCardTitle,
                      ),
                      Text(
                        sight.details,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.sightCardDetails,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

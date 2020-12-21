import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/widgets/network_image_with_spinner.dart';

/// Карточка "Интересного места" для списка мест
///
/// Используется в списке мест на странице [SightListScreen]
/// [onTap] вызывается при тапе на карточку
/// [onFavoriteTap] вызывается при тапе на сердечко
class SightCard extends StatelessWidget {
  final Sight sight;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  const SightCard({
    Key key,
    @required this.sight,
    this.onTap,
    this.onFavoriteTap,
  })  : assert(sight != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: NetworkImageWithSpinner(url: sight.url),
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
            Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () => onTap?.call(),
                child: Container(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    sight.type,
                    style: AppTextStyles.sightCardType.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24.0),
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        onTap: () => onFavoriteTap?.call(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgIcon(
                            icon: SvgIcons.heart,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

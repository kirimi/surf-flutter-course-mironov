import 'package:flutter/material.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/screen/sight_details_screen/widget/sight_photos_carousel.dart';

/// Sliver-делегат для заголовка с каруселью фото
///
/// [photos] - список фото для карусели
/// [onBackTap] - при тапе на кнопку back
class DetailsSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  final List<String> photos;
  final VoidCallback onBackTap;

  DetailsSliverPersistentHeaderDelegate({
    @required this.photos,
    @required this.onBackTap,
  })  : assert(photos != null && onBackTap != null),
        super();

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    // При скролле кнопка "back" и ушко делаеются прозрачными,
    // в середине скролла.
    // Высчитываем прозрачность в соответствии с shrinkOffset
    final startOpacityOffset = maxExtent - 200;
    final endOpacityOffset = maxExtent - 100;
    final currentOpacityOffset =
        shrinkOffset.clamp(startOpacityOffset, endOpacityOffset).toDouble() -
            startOpacityOffset;
    final opacity =
        1 - currentOpacityOffset / (endOpacityOffset - startOpacityOffset);

    return Stack(
      children: [
        SightPhotosCarousel(photos: photos),

        // Кнопка закрытия
        Opacity(
          opacity: opacity,
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 16.0),
              child: InkWell(
                onTap: onBackTap,
                child: SvgIcon(
                  icon: SvgIcons.clear,
                  size: 40,
                  color: Theme.of(context).backgroundColor,
                ),
              ),
            ),
          ),
        ),

        // Ушко
        Opacity(
          opacity: opacity,
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Container(
                height: 4.0,
                width: 40.0,
                color: Theme.of(context).backgroundColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 300;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

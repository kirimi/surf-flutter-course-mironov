import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/screen/sight_details_screen/widget/sight_photos_carousel.dart';
import 'package:places/ui/widgets/icon_elevated_button.dart';
import 'package:places/ui/widgets/icon_text_button.dart';

/// BottomSheet подробного представления "Интересного места"
class SightDetailsBottomSheet extends StatefulWidget {
  final Sight sight;

  const SightDetailsBottomSheet({
    Key key,
    @required this.sight,
  })  : assert(sight != null),
        super(key: key);

  @override
  _SightDetailsBottomSheetState createState() =>
      _SightDetailsBottomSheetState();
}

class _SightDetailsBottomSheetState extends State<SightDetailsBottomSheet> {
  // Высота карусели фото
  static const _headerHeight = 300.0;

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 0.9;

    return ConstrainedBox(
      constraints: BoxConstraints.expand(height: maxHeight),
      child: Stack(
        children: [
          // карусель фото, за которую можно свайпнуть вниз для закрытия bottomsheet
          SizedBox(
            height: _headerHeight,
            child: SightPhotosCarousel(
              list: sightPhotosMocks,
            ),
          ),

          // Кнопка закрытия
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 16.0),
              child: InkWell(
                onTap: _onBack,
                child: SvgIcon(
                  icon: SvgIcons.clear,
                  size: 40,
                  color: Theme.of(context).backgroundColor,
                ),
              ),
            ),
          ),

          // Ушко
          Align(
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

          // Текстовый контент и кнопки, со скролом.
          // Делаем отступ сверху на высоту карусели с фото.
          Padding(
            padding: const EdgeInsets.only(top: _headerHeight),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(widget.sight.name,
                            style: AppTextStyles.sightDetailsTitle),
                        const SizedBox(height: 2.0),
                        Text(widget.sight.type.name,
                            style: AppTextStyles.sightDetailsType),
                        const SizedBox(height: 24.0),
                        Text(widget.sight.details,
                            style: AppTextStyles.sightDetailsDetails),
                        const SizedBox(height: 24.0),
                        IconElevatedButton(
                          icon: SvgIcons.route,
                          text: AppStrings.sightDetailsRouteToBtn.toUpperCase(),
                          onPressed: () {},
                        ),
                        const SizedBox(height: 32.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const IconTextButton(
                              icon: SvgIcons.calendar,
                              text: AppStrings.sightDetailsPlanBtn,
                            ),
                            IconTextButton(
                              icon: SvgIcons.heart,
                              text: AppStrings.sightDetailsToFavoriteBtn,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onBack() {
    Navigator.of(context).pop();
  }
}

import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/screen/sight_details_screen/widget/sight_photos_carousel.dart';
import 'package:places/ui/widgets/icon_elevated_button.dart';
import 'package:places/ui/widgets/icon_text_button.dart';

/// Экран подробного представления "Интересного места"
class SightDetailsScreen extends StatefulWidget {
  final Sight sight;

  const SightDetailsScreen({Key key, @required this.sight}) : super(key: key);

  @override
  _SightDetailsScreenState createState() => _SightDetailsScreenState();
}

class _SightDetailsScreenState extends State<SightDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                SightPhotosCarousel(list: sightPhotosMocks),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 36.0),
                  child: InkWell(
                    onTap: _onBack,
                    child: Container(
                      height: 32.0,
                      width: 32.0,
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 16.0,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
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
                      onPressed: () {
                        // print('${AppStrings.sightDetailsRouteToBtn} tapped');
                      },
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
                          onPressed: () {
                            // print(
                            //     '${AppStrings.sightDetailsToFavoriteBtn} tapped');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onBack() {
    Navigator.of(context).pop();
  }
}

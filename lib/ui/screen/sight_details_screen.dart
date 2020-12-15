import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/widgets/big_button.dart';
import 'package:places/ui/widgets/network_image_with_spinner.dart';

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
                Container(
                  height: double.infinity,
                  child: NetworkImageWithSpinner(url: widget.sight.url),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 36.0),
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
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(widget.sight.name, style: AppTextStyles.sightDetailsTitle),
                    SizedBox(height: 2.0),
                    Text(widget.sight.type, style: AppTextStyles.sightDetailsType),
                    SizedBox(height: 24.0),
                    Text(widget.sight.details, style: AppTextStyles.sightDetailsDetails),
                    SizedBox(height: 24.0),
                    BigButton(
                      text: AppStrings.sightDetailsRouteToBtn.toUpperCase(),
                      icon: Icons.repeat_outlined,
                      bgColor: Theme.of(context).accentColor,
                      onPressed: () {},
                    ),
                    SizedBox(height: 32.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BigButton(
                          text: AppStrings.sightDetailsPlanBtn,
                          icon: Icons.calendar_today_outlined,
                          bgColor: Colors.transparent,
                          disabledBgColor: AppColors.transparent,
                          color: Theme.of(context).primaryColor,
                          disabledColor: Theme.of(context).disabledColor,
                          style: AppTextStyles.sightDetailsBtn,
                          enabled: false,
                          onPressed: () {},
                        ),
                        BigButton(
                          text: AppStrings.sightDetailsToFavoriteBtn,
                          icon: Icons.favorite_outline,
                          bgColor: Colors.transparent,
                          disabledBgColor: AppColors.transparent,
                          color: Theme.of(context).primaryColor,
                          disabledColor: Theme.of(context).disabledColor,
                          style: AppTextStyles.sightDetailsBtn,
                          enabled: true,
                          onPressed: () {},
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
}

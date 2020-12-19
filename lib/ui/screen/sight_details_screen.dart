import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
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
                    ElevatedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.repeat_outlined),
                          SizedBox(width: 10),
                          Text(AppStrings.sightDetailsRouteToBtn.toUpperCase()),
                        ],
                      ),
                      onPressed: () => print('${AppStrings.sightDetailsRouteToBtn} tapped'),
                    ),
                    SizedBox(height: 32.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.calendar_today_outlined),
                              SizedBox(width: 10),
                              Text(AppStrings.sightDetailsPlanBtn),
                            ],
                          ),
                          onPressed: null,
                        ),
                        TextButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.favorite_outline),
                              SizedBox(width: 10),
                              Text(AppStrings.sightDetailsToFavoriteBtn),
                            ],
                          ),
                          onPressed: () => print('${AppStrings.sightDetailsToFavoriteBtn} tapped'),
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

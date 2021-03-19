import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/screen/map_screen/map_wm.dart';
import 'package:places/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

/// Экран карта
class MapScreen extends CoreMwwmWidget {
  static const String routeName = 'MapScreen';

  const MapScreen({@required WidgetModelBuilder wmBuilder})
      : assert(wmBuilder != null),
        super(widgetModelBuilder: wmBuilder);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends WidgetState<MapWm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.mapAppBarTitle,
          style: AppTextStyles.appBarTitle.copyWith(
            color: Theme.of(context).primaryColor,
          ),
        ),
        backgroundColor: AppColors.transparent,
        elevation: 0,
      ),
      bottomNavigationBar: const CustomBottomNavBar(index: 1),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: const YandexMap(),
      ),
    );
  }
}

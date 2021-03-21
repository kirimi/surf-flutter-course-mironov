import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/screen/map_screen/map_wm.dart';
import 'package:places/ui/screen/map_screen/widget/bottom_map_controls.dart';
import 'package:places/ui/screen/map_screen/widget/bottom_map_controls_with_sight.dart';
import 'package:places/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:places/ui/widgets/loading_spinner.dart';
import 'package:relation/relation.dart';
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: StreamedStateBuilder<Sight>(
        streamedState: wm.selectedSight,
        builder: (context, sight) {
          if (sight != null) {
            return BottomMapControlsWithSight(
              sight: sight,
              onTap: () => wm.showDetails(sight),
              onClose: wm.cancelSelection,
              onRefresh: wm.refresh,
              onMoveToUser: wm.moveToUser,
            );
          }
          return BottomMapControls(
            onAddSight: () {},
            onRefresh: wm.refresh,
            onMoveToUser: wm.moveToUser,
          );
        },
      ),
      body: Stack(
        children: [
          YandexMap(
            onMapCreated: (YandexMapController controller) =>
                wm.initMap(controller),
          ),
          EntityStateBuilder(
            streamedState: wm.loading,
            child: (context, state) {
              return const SizedBox.shrink();
            },
            loadingChild: const Center(
              child: LoadingSpinner(),
            ),
          ),
        ],
      ),
    );
  }
}

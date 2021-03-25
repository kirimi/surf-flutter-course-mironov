import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/screen/add_sight_screen/select_location_screen/select_location_wm.dart';
import 'package:places/ui/widgets/icon_text_button.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

/// Экран выбора геопозиции для новго места
class SelectLocationScreen extends CoreMwwmWidget {
  static const String routeName = 'SelectLocationScreen';

  const SelectLocationScreen({@required WidgetModelBuilder wmBuilder})
      : assert(wmBuilder != null),
        super(widgetModelBuilder: wmBuilder);

  @override
  _SelectLocationScreenState createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends WidgetState<SelectLocationWm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.selectLocationAppbarTitle),
        leading: IconTextButton(
          icon: SvgIcons.arrowLeft,
          onPressed: wm.back,
        ),
        actions: [
          TextButton(
            onPressed: wm.submit,
            child: const Text(AppStrings.selectLocationSubmit),
          ),
        ],
      ),
      body: YandexMap(
        onMapCreated: (YandexMapController controller) =>
            wm.initMap(controller),
      ),
    );
  }
}

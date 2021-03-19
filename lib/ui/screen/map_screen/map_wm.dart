import 'package:flutter/cupertino.dart';
import 'package:mwwm/mwwm.dart';

/// wm для экрана карты
class MapWm extends WidgetModel {
  MapWm(WidgetModelDependencies baseDependencies, Model model, this.navigator)
      : super(baseDependencies, model: model);

  final NavigatorState navigator;
}

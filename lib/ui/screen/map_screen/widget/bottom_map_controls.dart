import 'package:flutter/material.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/widgets/add_button.dart';
import 'package:places/ui/widgets/circular_icon_button.dart';

/// Кнопки управления
class BottomMapControls extends StatelessWidget {
  final VoidCallback onAddSight;
  final VoidCallback onRefresh;
  final VoidCallback onMoveToUser;

  const BottomMapControls({
    Key key,
    @required this.onAddSight,
    @required this.onRefresh,
    @required this.onMoveToUser,
  })  : assert(onAddSight != null),
        assert(onRefresh != null),
        assert(onMoveToUser != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: CircularIconButton(
            icon: SvgIcons.refresh,
            onPressed: onRefresh,
          ),
        ),
        AddButton(onPressed: onAddSight),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: CircularIconButton(
            icon: SvgIcons.geolocation,
            onPressed: onMoveToUser,
          ),
        ),
      ],
    );
  }
}

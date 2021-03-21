import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/const.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/screen/sight_list_screen/widget/favorite_button/favorite_button.dart';
import 'package:places/ui/widgets/circular_icon_button.dart';
import 'package:places/ui/widgets/sight_card.dart';

/// кнопки управления + Карточка выбранного места
class BottomMapControlsWithSight extends StatefulWidget {
  final Sight sight;
  final VoidCallback onTap;
  final VoidCallback onClose;
  final VoidCallback onRefresh;
  final VoidCallback onMoveToUser;

  const BottomMapControlsWithSight({
    Key key,
    @required this.sight,
    @required this.onTap,
    @required this.onClose,
    @required this.onRefresh,
    @required this.onMoveToUser,
  })  : assert(sight != null),
        assert(onTap != null),
        assert(onClose != null),
        assert(onRefresh != null),
        assert(onMoveToUser != null),
        super(key: key);

  @override
  _BottomMapControlsWithSightState createState() =>
      _BottomMapControlsWithSightState();
}

class _BottomMapControlsWithSightState extends State<BottomMapControlsWithSight>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Const.duration200,
    );
    _offset = Tween<Offset>(
      begin: const Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(_animationController);

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, widget) {
        return SlideTransition(
          position: _offset,
          child: widget,
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: CircularIconButton(
                  icon: SvgIcons.refresh,
                  onPressed: widget.onRefresh,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: CircularIconButton(
                  icon: SvgIcons.geolocation,
                  onPressed: widget.onMoveToUser,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: PhysicalModel(
              color: Colors.transparent,
              elevation: 4,
              borderRadius: BorderRadius.circular(24.0),
              child: SightCard(
                sight: widget.sight,
                onTap: widget.onTap,
                actionsBuilder: (_) {
                  return [
                    FavoriteButton(sight: widget.sight),
                    SightCardActionButton(
                      onTap: widget.onClose,
                      icon: SvgIcons.delete,
                    ),
                  ];
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

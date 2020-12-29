import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/widgets/sight_card.dart';

typedef OnSightDrop = Function(Sight sight);

/// Карточка места, которую можно двигать по LongPress
///
/// если на карточку при drag попадает другая каточка,
/// то вызывается [onSightDrop] с параметром что на нее упало
class DraggableSightCard extends StatelessWidget {
  final Sight sight;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;
  final OnSightDrop onSightDrop;

  const DraggableSightCard({
    Key key,
    @required this.sight,
    @required this.onTap,
    @required this.onFavoriteTap,
    @required this.onSightDrop,
  })  : assert(sight != null),
        assert(onTap != null),
        assert(onFavoriteTap != null),
        assert(onSightDrop != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragTarget<Sight>(
      onAccept: (droppedSight) => onSightDrop(droppedSight),
      onWillAccept: (_) => true,
      builder: (BuildContext context, List<dynamic> candidateData,
          List<dynamic> rejectedData) {
        // LayoutBuilder чтобы задать у feedback ширину
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final Widget sightWidget = SightCard(
              sight: sight,
              onTap: onTap,
              onFavoriteTap: onFavoriteTap,
            );

            return LongPressDraggable<Sight>(
              axis: Axis.vertical,
              data: sight,
              // Material, чтобы текстовые стили соответствовали.
              feedback: Material(
                child: Container(
                  width: constraints.maxWidth,
                  // Добавляем тень, словно элемент приподнялся
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: sightWidget,
                ),
              ),
              // Старый элемент показываем с полупрозрачностью.
              childWhenDragging: Opacity(
                opacity: 0.5,
                child: sightWidget,
              ),
              child: sightWidget,
            );
          },
        );
      },
    );
  }
}

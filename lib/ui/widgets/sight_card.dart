import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/widgets/network_image_with_spinner.dart';

/// Карточка "Интересного места" для списка мест
///
/// Используется в списке мест на странице [SightListScreen]
/// [onTap] вызывается при тапе на карточку
/// Если заданы [onFavoriteTap] [onDeleteTap] [onShareTap] [onCalendarTap], то на карточке
/// выводится соответствующая кнопка
class SightCard extends StatelessWidget {
  final Sight sight;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;
  final VoidCallback onDeleteTap;
  final VoidCallback onShareTap;
  final VoidCallback onCalendarTap;

  const SightCard({
    Key key,
    @required this.sight,
    @required this.onTap,
    this.onFavoriteTap,
    this.onDeleteTap,
    this.onShareTap,
    this.onCalendarTap,
  })  : assert(sight != null),
        assert(onTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: AspectRatio(
        aspectRatio: 4 / 2,
        child: Container(
          color: Theme.of(context).cardColor,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: NetworkImageWithSpinner(url: sight.url),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sight.name,
                            maxLines: 2,
                            style: AppTextStyles.sightCardTitle,
                          ),
                          Text(
                            sight.details,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.sightCardDetails,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: onTap,
                  child: Container(),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      sight.type.name,
                      style: AppTextStyles.sightCardType.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: _buildActionButtons(),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildActionButtons() {
    final List<Widget> actions = [];

    if (onFavoriteTap != null) {
      actions.add(
        _ActionButton(
          onTap: onFavoriteTap,
          icon: SvgIcons.heart,
        ),
      );
    }

    if (onCalendarTap != null) {
      actions.add(
        _ActionButton(
          onTap: onCalendarTap,
          icon: SvgIcons.calendar,
        ),
      );
    }

    if (onShareTap != null) {
      actions.add(
        _ActionButton(
          onTap: onShareTap,
          icon: SvgIcons.share,
        ),
      );
    }

    if (onDeleteTap != null) {
      actions.add(
        _ActionButton(
          onTap: onDeleteTap,
          icon: SvgIcons.delete,
        ),
      );
    }

    return actions;
  }
}

/// Кнопка которая выводится в правом верхнем углу.
class _ActionButton extends StatelessWidget {
  final VoidCallback onTap;
  final SvgData icon;

  const _ActionButton({Key key, @required this.onTap, @required this.icon})
      : assert(onTap != null),
        assert(icon != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24.0),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgIcon(
              icon: icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

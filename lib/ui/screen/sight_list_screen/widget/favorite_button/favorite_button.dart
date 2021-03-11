import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/domain/sight.dart';
import 'package:places/model/favorites/performers.dart';
import 'package:places/model/repository/favorites_repository.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/screen/sight_list_screen/widget/favorite_button/favorite_button_wm.dart';
import 'package:places/ui/widgets/sight_card.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';

/// Кнопка избранное для карточки места.
class FavoriteButton extends CoreMwwmWidget {
  FavoriteButton({@required Sight sight, Model model})
      : super(widgetModelBuilder: (context) {
          return FavoriteButtonWm(
            context.read<WidgetModelDependencies>(),
            Model([
              GetFavoriteStatePerformer(context.read<FavoritesRepository>()),
              context.read<ToggleFavoritePerformer>(),
            ]),
            sight: sight,
          );
        });

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends WidgetState<FavoriteButtonWm> {
  @override
  Widget build(BuildContext context) {
    return StreamedStateBuilder<bool>(
      streamedState: wm.isFavorite,
      builder: (context, isFav) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: SightCardActionButton(
            key: ObjectKey(isFav),
            onTap: wm.onTap,
            icon: isFav ? SvgIcons.heartFill : SvgIcons.heart,
          ),
        );
      },
    );
  }
}

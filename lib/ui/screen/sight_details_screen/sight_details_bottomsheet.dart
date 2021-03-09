import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/model/favorites/performers.dart';
import 'package:places/model/repository/favorites_repository.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/screen/sight_details_screen/sight_details_wm.dart';
import 'package:places/ui/screen/sight_details_screen/widget/details_sliver_persistent_header_delegate.dart';
import 'package:places/ui/widgets/icon_elevated_button.dart';
import 'package:places/ui/widgets/icon_text_button.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';

/// BottomSheet подробного представления "Интересного места"
class SightDetailsBottomSheet extends CoreMwwmWidget {
  SightDetailsBottomSheet({@required Sight sight, Model model})
      : assert(sight != null),
        super(widgetModelBuilder: (context) {
          return SightDetailsWm(
            context.read<WidgetModelDependencies>(),
            model ??
                Model([
                  AddToFavoritePerformer(
                    context.read<FavoritesRepository>(),
                  ),
                  RemoveFromFavoritePerformer(
                    context.read<FavoritesRepository>(),
                  ),
                  GetFavoriteStatePerformer(
                    context.read<FavoritesRepository>(),
                  ),
                ]),
            Navigator.of(context),
            sight: sight,
          );
        });

  @override
  _SightDetailsBottomSheetState createState() =>
      _SightDetailsBottomSheetState();
}

class _SightDetailsBottomSheetState extends WidgetState<SightDetailsWm> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 0.9,
      minChildSize: 0.6,
      initialChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverPersistentHeader(
                  delegate: DetailsSliverPersistentHeaderDelegate(
                    photos: sightPhotosMocks,
                    onBackTap: wm.onBack,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(wm.sight.name,
                            style: AppTextStyles.sightDetailsTitle),
                        const SizedBox(height: 2.0),
                        Text(wm.sight.type.name,
                            style: AppTextStyles.sightDetailsType),
                        const SizedBox(height: 24.0),
                        Text(wm.sight.details,
                            style: AppTextStyles.sightDetailsDetails),
                        const SizedBox(height: 24.0),
                        IconElevatedButton(
                          icon: SvgIcons.route,
                          text: AppStrings.sightDetailsRouteToBtn.toUpperCase(),
                          onPressed: () {},
                        ),
                        const SizedBox(height: 32.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const IconTextButton(
                              icon: SvgIcons.calendar,
                              text: AppStrings.sightDetailsPlanBtn,
                            ),
                            StreamedStateBuilder<bool>(
                              streamedState: wm.isFavorite,
                              builder: (context, isFavorite) {
                                return IconTextButton(
                                  onPressed: wm.onFavorite,
                                  text: AppStrings.sightDetailsToFavoriteBtn,
                                  icon: isFavorite
                                      ? SvgIcons.heartFill
                                      : SvgIcons.heart,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

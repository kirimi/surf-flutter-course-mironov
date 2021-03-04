import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/domain/sight_photo.dart';
import 'package:places/domain/sight_type/sight_type.dart';
import 'package:places/interactor/sight_interactor.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/screen/add_sight_screen/add_sight_wm.dart';
import 'package:places/ui/screen/add_sight_screen/widget/category_selector.dart';
import 'package:places/ui/screen/add_sight_screen/widget/sight_photos_list_widget.dart';
import 'package:places/ui/widgets/icon_elevated_button.dart';
import 'package:places/ui/widgets/label.dart';
import 'package:places/ui/widgets/text_field_with_clear.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';

// Билдер для WidgetModel
WidgetModel _buildWm(BuildContext context) {
  return AddScreenWm(
    context.read<WidgetModelDependencies>(),
    sightInteractor: context.read<SightInteractor>(),
    navigator: Navigator.of(context),
  );
}

/// Экран добавления нового места
class AddSightScreen extends CoreMwwmWidget {
  static const String routeName = 'AddSightScreen';

  const AddSightScreen({
    WidgetModelBuilder wmBuilder,
  }) : super(widgetModelBuilder: wmBuilder ?? _buildWm);

  @override
  _AddSightScreenState createState() => _AddSightScreenState();
}

class _AddSightScreenState extends WidgetState<AddScreenWm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.addSightAppbarTitle),
        leading: TextButton(
          onPressed: wm.backPressed,
          child: const Text(AppStrings.addSightAppbarCancel),
        ),
        leadingWidth: 100.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            // Отступ  снизу, чтобы скролл под кнопку не забирался.
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              // SingleChildScrollView - чтобы при появлении клавиатуры не было overflow
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamedStateBuilder<List<SightPhoto>>(
                      streamedState: wm.sightPhotos,
                      builder: (context, list) {
                        return SightPhotosListWidget(
                          sightPhotos: list,
                          onTap: (int index) {},
                          onAdd: wm.addPhoto,
                          onDelete: (int index) => wm.deletePhoto(index),
                        );
                      },
                    ),
                    const Label(
                      text: AppStrings.addSightCategory,
                      padding: EdgeInsets.all(0),
                    ),
                    StreamedStateBuilder<SightType>(
                      streamedState: wm.sightType,
                      builder: (context, sightType) {
                        return CategorySelector(
                          value: sightType,
                          onTap: wm.selectSightType,
                        );
                      },
                    ),
                    const Divider(),
                    const SizedBox(height: 24.0),
                    const Label(text: AppStrings.addSightFormTitle),
                    TextFieldWithClear(
                      hintText: AppStrings.addSightHintTitle,
                      controller: wm.title.controller,
                      focusNode: wm.titleFocusNode,
                      onSubmitted: (_) => wm.submitTextField(wm.latFocusNode),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 24.0),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Label(
                                  text: AppStrings.addSightFormLatitude),
                              TextFieldWithClear(
                                hintText: AppStrings.addSightHintLatitude,
                                focusNode: wm.latFocusNode,
                                onSubmitted: (_) =>
                                    wm.submitTextField(wm.lonFocusNode),
                                controller: wm.lat.controller,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Label(
                                  text: AppStrings.addSightFormLongitude),
                              TextFieldWithClear(
                                hintText: AppStrings.addSightHintLongitude,
                                focusNode: wm.lonFocusNode,
                                onSubmitted: (_) =>
                                    wm.submitTextField(wm.descrFocusNode),
                                controller: wm.lon.controller,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          primary: Theme.of(context).accentColor),
                      child: const Text(AppStrings.addSightGetFromMap),
                    ),
                    const SizedBox(height: 24.0),
                    const Label(text: AppStrings.addSightFormDescription),
                    TextFieldWithClear(
                      hintText: AppStrings.addSightHintDescription,
                      maxLines: 3,
                      focusNode: wm.descrFocusNode,
                      onSubmitted: (_) => wm.submitTextField(),
                      controller: wm.description.controller,
                      textInputAction: TextInputAction.go,
                    ),
                  ],
                ),
              ),
            ),

            // Кнопка "Создать" всегда прижата к низу.
            Align(
              alignment: Alignment.bottomCenter,
              child: StreamedStateBuilder<bool>(
                streamedState: wm.isSubmitEnabled,
                builder: (context, inEnabled) {
                  return IconElevatedButton(
                    text: AppStrings.addSightBtnCreate,
                    onPressed: inEnabled ? wm.submit : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

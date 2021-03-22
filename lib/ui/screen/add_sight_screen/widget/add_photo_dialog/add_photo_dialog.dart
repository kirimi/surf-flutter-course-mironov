import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/model/photo/preformers.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';
import 'package:places/ui/screen/add_sight_screen/widget/add_photo_dialog/add_photo_dialog_wm.dart';
import 'package:places/ui/widgets/loading_spinner.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';

enum _SourceChoice { camera, photo }

/// Диалог добавления фотографии с разных источников. camera, photo
/// Возвращает [File] c фотографией или null
class AddPhotoDialog extends CoreMwwmWidget {
  AddPhotoDialog()
      : super(
          widgetModelBuilder: (context) => AddPhotoDialogWm(
            context.read<WidgetModelDependencies>(),
            navigator: Navigator.of(context),
            model: Model([
              ResizePhotoPerformer(),
            ]),
          ),
        );

  @override
  _AddPhotoDialogState createState() => _AddPhotoDialogState();
}

class _AddPhotoDialogState extends WidgetState<AddPhotoDialogWm> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamedStateBuilder<bool>(
          streamedState: wm.resizing,
          builder: (context, isResizing) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _AddButtons(onSelect: (choice) {
                      switch (choice) {
                        case _SourceChoice.camera:
                          wm.camera();
                          break;
                        case _SourceChoice.photo:
                          wm.photo();
                          break;
                      }
                    }),
                    const SizedBox(height: 16.0),
                    _CancelButton(onSelect: wm.cancel)
                  ],
                ),
                if (isResizing)
                  const Center(
                    child: LoadingSpinner(),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Группа кнопок выбора источника.
class _AddButtons extends StatelessWidget {
  final ValueChanged<_SourceChoice> onSelect;

  const _AddButtons({
    Key key,
    @required this.onSelect,
  })  : assert(onSelect != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Theme.of(context).backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _AddButton(
              icon: SvgIcons.camera,
              text: AppStrings.addPhotoCamera,
              onPressed: () {
                onSelect(_SourceChoice.camera);
              },
            ),
            const Divider(),
            _AddButton(
              icon: SvgIcons.photo,
              text: AppStrings.addPhotoPhoto,
              onPressed: () {
                onSelect(_SourceChoice.photo);
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Кнопка выбора источника фото
class _AddButton extends StatelessWidget {
  final SvgData icon;
  final String text;
  final VoidCallback onPressed;

  const _AddButton({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.onPressed,
  })  : assert(icon != null),
        assert(text != null),
        assert(onPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            SvgIcon(icon: icon, color: AppColors.lightGray),
            const SizedBox(width: 12),
            Text(
              text,
              style: AppTextStyles.addPhotoDialogButton
                  .copyWith(color: AppColors.lightGray),
            ),
          ],
        ),
      ),
    );
  }
}

/// Кнопка отмены
class _CancelButton extends StatelessWidget {
  final VoidCallback onSelect;

  const _CancelButton({
    Key key,
    @required this.onSelect,
  })  : assert(onSelect != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onSelect,
        child: Ink(
          height: 48.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Theme.of(context).backgroundColor,
          ),
          child: Center(
            child: Text(
              AppStrings.addPhotoCancel.toUpperCase(),
              style: AppTextStyles.addPhotoDialogButton
                  .copyWith(color: Theme.of(context).accentColor),
            ),
          ),
        ),
      ),
    );
  }
}

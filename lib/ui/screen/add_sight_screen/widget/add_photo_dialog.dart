import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
import 'package:places/ui/res/svg_icons/svg_icon.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';

/// Коды возврата с диалога добавления фото
class AddPhotoDialogResultCode {
  static const int cameraSelected = 1;
  static const int photoSelected = 2;
  static const int fileSelected = 3;
  static const int cancelSelected = -1;
}

/// Диалог выбора источника добавления фото
class AddPhotoDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _AddButtons(onSelect: (value) => onSelect(context, value)),
            const SizedBox(height: 16.0),
            _CancelButton(
              onSelect: () => onSelect(
                context,
                AddPhotoDialogResultCode.cancelSelected,
              ),
            )
          ],
        ),
      ),
    );
  }

  /// При выборе возвращает код из [AddPhotoDialogResultCode]
  void onSelect(BuildContext context, int value) {
    Navigator.of(context).pop(value);
  }
}

// Группа кнопок выбора источника.
class _AddButtons extends StatelessWidget {
  final ValueChanged<int> onSelect;

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
                onSelect(AddPhotoDialogResultCode.cameraSelected);
              },
            ),
            const Divider(),
            _AddButton(
              icon: SvgIcons.photo,
              text: AppStrings.addPhotoPhoto,
              onPressed: () {
                onSelect(AddPhotoDialogResultCode.photoSelected);
              },
            ),
            const Divider(),
            _AddButton(
              icon: SvgIcons.file,
              text: AppStrings.addPhotoFile,
              onPressed: () {
                onSelect(AddPhotoDialogResultCode.fileSelected);
              },
            )
          ],
        ),
      ),
    );
  }
}

// Кнопка выбора источника фото
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

// Кнопка отмены
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

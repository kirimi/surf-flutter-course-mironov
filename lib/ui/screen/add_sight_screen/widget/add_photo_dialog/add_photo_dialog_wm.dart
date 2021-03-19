import 'dart:io';

import 'package:flutter/material.dart' hide Action;
import 'package:image_picker/image_picker.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';

/// WM для диалога выбора и загрузки фото
class AddPhotoDialogWm extends WidgetModel {
  AddPhotoDialogWm(
    WidgetModelDependencies baseDependencies, {
    @required this.navigator,
  })  : assert(navigator != null),
        super(baseDependencies);

  final NavigatorState navigator;

  final picker = ImagePicker();

  /// нажата "камера"
  final camera = Action<void>();

  /// Нажата "фото"
  final photo = Action<void>();

  /// Нажата кнопка отмена
  final cancel = Action<void>();

  @override
  void onBind() {
    super.onBind();
    subscribe(cancel.stream, (_) => onCancel());
    subscribe(camera.stream, (_) => onCamera());
    subscribe(photo.stream, (_) => onPhoto());
  }

  /// Снимок с камеры
  Future<void> onCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      navigator.pop(File(pickedFile.path));
    } else {
      onCancel();
    }
  }

  /// Фотография с галереи
  Future<void> onPhoto() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      navigator.pop(File(pickedFile.path));
    } else {
      onCancel();
    }
  }

  /// Закрытие диалога
  void onCancel() => navigator.pop();
}

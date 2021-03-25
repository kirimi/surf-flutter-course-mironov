import 'dart:io';

import 'package:flutter/material.dart' hide Action;
import 'package:image_picker/image_picker.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/model/photo/changes.dart';
import 'package:relation/relation.dart';

/// WM для диалога выбора и загрузки фото
class AddPhotoDialogWm extends WidgetModel {
  AddPhotoDialogWm(
    WidgetModelDependencies baseDependencies, {
    @required this.navigator,
    Model model,
  })  : assert(navigator != null),
        super(baseDependencies, model: model);

  final NavigatorState navigator;

  final picker = ImagePicker();

  final StreamedState<bool> resizing = StreamedState<bool>(false);

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
      _resideAndPop(File(pickedFile.path));
    } else {
      onCancel();
    }
  }

  /// Фотография с галереи
  Future<void> onPhoto() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _resideAndPop(File(pickedFile.path));
    } else {
      onCancel();
    }
  }

  /// Закрытие диалога
  void onCancel() => navigator.pop();

  /// масштабирует/сжимает фото и возвращает
  Future<void> _resideAndPop(File image) async {
    resizing.accept(true);
    final resized = await model.perform(ResizePhoto(image));
    resizing.accept(false);

    navigator.pop(resized);
  }
}

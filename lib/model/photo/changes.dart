import 'dart:io';

import 'package:mwwm/mwwm.dart';

/// Загрузить фотографии на сервер
class UploadPhotos extends FutureChange<List<String>> {
  final List<File> photos;

  UploadPhotos(this.photos);
}

/// Масштабировать фото
class ResizePhoto extends FutureChange<File> {
  final File photo;

  ResizePhoto(this.photo);
}

import 'dart:io';

import 'package:mwwm/mwwm.dart';

/// Загрузить фотографии на сервер
class UploadPhotos extends FutureChange<List<String>> {
  final List<File> photos;

  UploadPhotos(this.photos);
}

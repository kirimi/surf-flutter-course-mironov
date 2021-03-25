import 'dart:convert';
import 'dart:io';

import 'package:mwwm/mwwm.dart';
import 'package:places/data/network_client/network_client.dart';
import 'package:places/model/photo/changes.dart';
import 'package:places/utils/photo_resizer/photo_resizer.dart';

/// Загрузка фотографий на сервер
/// возвращает список url для загруженных фотографий
class UploadPhotosPerformer
    extends FuturePerformer<List<String>, UploadPhotos> {
  final NetworkClient networkClient;
  static const String uploadUrl = '/upload_file';

  UploadPhotosPerformer(this.networkClient);

  @override
  Future<List<String>> perform(UploadPhotos change) async {
    final response = await networkClient.uploadPhotos(uploadUrl, change.photos);
    final map = jsonDecode(response);
    final urls = (map['urls'] as List<dynamic>).cast<String>();
    return urls;
  }
}

/// Масштабирование фото
class ResizePhotoPerformer extends FuturePerformer<File, ResizePhoto> {
  @override
  Future<File> perform(ResizePhoto change) async {
    return resizeImage(change.photo);
  }
}

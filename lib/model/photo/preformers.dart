import 'package:dio/dio.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/data/network_client/network_client.dart';
import 'package:places/model/photo/changes.dart';
import 'package:uuid/uuid.dart';

/// Загрузка фотографий на сервер
/// возвращает список url для загруженных фотографий
class UploadPhotosPerformer
    extends FuturePerformer<List<String>, UploadPhotos> {
  final NetworkClient networkClient;
  static const String uploadUrl = '/upload_file';

  UploadPhotosPerformer(this.networkClient);

  @override
  Future<List<String>> perform(UploadPhotos change) async {
    final uuid = Uuid();
    final FormData formData = FormData();

    formData.files.addAll(
      change.photos.map(
        (e) => MapEntry(
          "files",
          MultipartFile.fromFileSync(e.path, filename: '${uuid.v4()}.jpg'),
        ),
      ),
    );

    // final result = await networkClient.post(uploadUrl, formData);
    // todo сервер возвращает 413 Request Entity Too Large.

    // возвращаем пока моки
    return [
      'https://picsum.photos/800/600?1',
      'https://picsum.photos/800/600?2',
      'https://picsum.photos/800/600?3',
    ];
  }
}

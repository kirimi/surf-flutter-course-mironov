import 'dart:io';
import 'dart:isolate';

import 'package:image/image.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

/// Изменяет размер фотографии до [resizeWidth] в ширину

/// результирующая ширина фото после масштабирования
const int resizeWidth = 300;

/// Изменяет размер фотографии в 600px в ширину
Future<File> resizeImage(File image) async {
  final receivePort = ReceivePort();

  await Isolate.spawn(
    _decodeIsolate,
    _PhotoResizerParams(image, receivePort.sendPort),
  );

  final result = await receivePort.first as Image;

  final appDir = await getApplicationDocumentsDirectory();

  final filename = basename(image.path);

  return File(join(appDir.path, filename)).writeAsBytes(encodeJpg(result));
}

/// Параметры для передачи в изолят
class _PhotoResizerParams {
  final File file;
  final SendPort sendPort;
  _PhotoResizerParams(this.file, this.sendPort);
}

/// ресайз картинки
void _decodeIsolate(_PhotoResizerParams param) {
  final image = decodeImage(param.file.readAsBytesSync());
  final resizedImg = copyResize(image, width: resizeWidth);
  param.sendPort.send(resizedImg);
}

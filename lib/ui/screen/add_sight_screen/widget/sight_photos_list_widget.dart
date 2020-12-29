import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:places/domain/sight_photo.dart';
import 'package:places/ui/screen/add_sight_screen/widget/add_photo_widget.dart';
import 'package:places/ui/screen/add_sight_screen/widget/sight_photo_widget.dart';

/// Список фотографий места
///
/// [sightPhotos] список [SightPhoto], который надо отобразить
/// [onTap] срабатываем при тапе на фото, в параметрах index
/// [onDeleteTap] при тапе на крестик,  в параметрах index
/// [onAddTap] при тапе на кнопку добавления фото, первый элемент
class SightPhotosListWidget extends StatelessWidget {
  final List<SightPhoto> sightPhotos;
  final ValueChanged<int> onTap;
  final VoidCallback onAddTap;
  final ValueChanged<int> onDeleteTap;

  const SightPhotosListWidget({
    Key key,
    @required this.sightPhotos,
    @required this.onTap,
    @required this.onDeleteTap,
    @required this.onAddTap,
  })  : assert(sightPhotos != null),
        assert(onTap != null),
        assert(onDeleteTap != null),
        assert(onAddTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        AddPhotoWidget(onTap: onAddTap),
        ..._buildPhotosList(),
      ]),
    );
  }

  List<Widget> _buildPhotosList() {
    final List<Widget> _photosList = [];

    for (var i = 0; i < sightPhotos.length; i++) {
      _photosList.add(
        SightPhotoWidget(
          photo: sightPhotos[i],
          onTap: () => onTap(i),
          onDelete: () => onDeleteTap(i),
        ),
      );
    }
    return _photosList;
  }
}

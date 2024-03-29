import 'dart:io';

import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:places/domain/geo_point.dart';
import 'package:places/domain/sight.dart';
import 'package:places/domain/sight_type/sight_type.dart';
import 'package:places/model/photo/changes.dart';
import 'package:places/model/sights/changes.dart';
import 'package:places/ui/screen/add_sight_screen/select_location_screen/select_location_screen.dart';
import 'package:places/ui/screen/add_sight_screen/widget/add_photo_dialog/add_photo_dialog.dart';
import 'package:places/ui/screen/select_category_screen.dart';
import 'package:relation/relation.dart';

/// WidgetModel для эрана добавления места
class AddScreenWm extends WidgetModel {
  AddScreenWm(
    WidgetModelDependencies baseDependencies,
    Model model, {
    @required this.navigator,
  })  : assert(navigator != null),
        super(baseDependencies, model: model);

  /// Навигатор
  final NavigatorState navigator;

  // временное хранилище для фотографий
  final List<File> _sightPhotoList = [];

  // -------------
  // States

  /// Доступна ли кнопка создания места
  final StreamedState<bool> isSubmitEnabled = StreamedState(false);

  /// Категория места
  final StreamedState<SightType> sightType = StreamedState();

  /// Фотографии места
  final StreamedState<List<File>> sightPhotos = StreamedState([]);

  /// идет процесс загрузки
  final StreamedState<bool> sending = StreamedState(false);

  /// FocusNode для полей ввода,
  /// по Action updateFocusNode происходит логика переключения фокуса
  /// updateFocusNode вызывается когда закончено редактирование поля (onSubmitted)
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode latFocusNode = FocusNode();
  final FocusNode lonFocusNode = FocusNode();
  final FocusNode descrFocusNode = FocusNode();

  // --------------
  // Actions

  /// Создать место
  final Action submit = Action<void>();

  /// Поля ввода текста
  final TextEditingAction title = TextEditingAction();
  final TextEditingAction lat = TextEditingAction();
  final TextEditingAction lon = TextEditingAction();
  final TextEditingAction description = TextEditingAction();

  /// Выбор категории места
  final selectSightType = Action<void>();

  /// Выбор категории места
  final backPressed = Action<void>();

  /// При submit текстового поля, в параметре следующий фокус
  final submitTextField = Action<FocusNode>();

  /// Добавление фотографии
  final addPhoto = Action<void>();

  /// Удаление фотографии
  final deletePhoto = Action<int>();

  /// Выбор локации на карте
  final selectLocation = Action<void>();

  @override
  void onBind() {
    super.onBind();
    subscribe(submit.stream, _onSubmit);
    subscribe(selectSightType.stream, _onSelectSightType);
    subscribe(backPressed.stream, _onBackPressed);
    subscribe(submitTextField.stream, _onSubmitTextField);
    subscribe(addPhoto.stream, _onAddPhoto);
    subscribe(deletePhoto.stream, _onDeletePhoto);
    subscribe(selectLocation.stream, _onSelectLocation);
  }

  // Выбор категории места
  Future<void> _onSelectSightType(_) async {
    final result = await navigator.pushNamed(
      SelectCategoryScreen.routeName,
    ) as SightType;

    if (result != null) {
      sightType.accept(result);
      // если выбрана категория, то фокус на первом поле.
      _onSubmitTextField(titleFocusNode);
    }
  }

  void _onSubmitTextField(FocusNode focusNode) {
    // Обновляем фокус текущего поля ввода
    focusNode?.requestFocus();
    // Обновляем доступность кнопки создания места
    _checkSubmitEnabled();
  }

  // проверяем и устанавливаем доступность кнопки сознания места
  // если все заполнено, то кнопка доступна
  void _checkSubmitEnabled() {
    final bool isEnabled = sightType.value != null &&
        title.controller.text != '' &&
        lat.controller.text != '' &&
        lon.controller.text != '' &&
        description.controller.text != '' &&
        _sightPhotoList.isNotEmpty;

    isSubmitEnabled.accept(isEnabled);
  }

  // Создание нового места
  Future<void> _onSubmit(_) async {
    sending.accept(true);

    // Загружаем фотографии на сервер и получаем их пути на сервере.
    final List<String> urls =
        await model.perform(UploadPhotos(_sightPhotoList));

    final Sight newSight = Sight(
      name: title.controller.text,
      point: GeoPoint(
        lon: double.parse(lon.controller.text),
        lat: double.parse(lat.controller.text),
      ),
      details: description.controller.text,
      photos: urls,
      type: sightType.value,
    );

    model.perform(AddNewSight(newSight));

    sending.accept(false);
    navigator.pop();
  }

  // Добавление фотографии
  Future<void> _onAddPhoto(_) async {
    final File sightPhoto = await showDialog(
        context: navigator.context,
        builder: (_) {
          return AddPhotoDialog();
        });

    if (sightPhoto != null) {
      _sightPhotoList.insert(0, sightPhoto);
      sightPhotos.accept(_sightPhotoList);
    }
  }

  // Удаление фотографии
  void _onDeletePhoto(int index) {
    _sightPhotoList.removeAt(index);
    sightPhotos.accept(_sightPhotoList);
  }

  /// Выбор локации на карте, при возврате установка соответствующих полей
  Future<void> _onSelectLocation(_) async {
    final result =
        await navigator.pushNamed(SelectLocationScreen.routeName) as GeoPoint;
    if (result != null) {
      lat.controller.text = result.lat.toString();
      lon.controller.text = result.lon.toString();
    }
  }

  // Нажата кнопка "назад"
  void _onBackPressed(_) => navigator.pop();
}

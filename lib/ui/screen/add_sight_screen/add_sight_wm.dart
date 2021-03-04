import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:places/domain/geo_point.dart';
import 'package:places/domain/sight.dart';
import 'package:places/domain/sight_photo.dart';
import 'package:places/domain/sight_type/sight_type.dart';
import 'package:places/interactor/sight_interactor.dart';
import 'package:places/ui/screen/add_sight_screen/widget/add_photo_dialog.dart';
import 'package:places/ui/screen/select_category_screen.dart';
import 'package:relation/relation.dart';

/// WidgetModel для эрана добавления места
class AddScreenWm extends WidgetModel {
  AddScreenWm(
    WidgetModelDependencies baseDependencies, {
    @required this.sightInteractor,
    @required this.navigator,
  })  : assert(sightInteractor != null),
        assert(navigator != null),
        super(baseDependencies);

  /// Интерактор мест
  final SightInteractor sightInteractor;

  /// Навигатор
  final NavigatorState navigator;

  // временное хранилище для фотографий
  final List<SightPhoto> _sightPhotoList = [];

  // -------------
  // States

  /// Доступна ли кнопка создания места
  final StreamedState<bool> isSubmitEnabled = StreamedState(false);

  /// Категория места
  final StreamedState<SightType> sightType = StreamedState();

  /// Фотографии места
  final StreamedState<List<SightPhoto>> sightPhotos = StreamedState([]);

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

  @override
  void onBind() {
    super.onBind();
    subscribe(submit.stream, _onSubmit);
    subscribe(selectSightType.stream, _onSelectSightType);
    subscribe(backPressed.stream, _onBackPressed);
    subscribe(submitTextField.stream, _onSubmitTextField);
    subscribe(addPhoto.stream, _onAddPhoto);
    subscribe(deletePhoto.stream, _onDeletePhoto);
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
        description.controller.text != '';

    isSubmitEnabled.accept(isEnabled);
  }

  // Создание нового места
  Future<void> _onSubmit(_) async {
    final Sight newSight = Sight(
      name: title.controller.text,
      point: GeoPoint(
        lon: double.parse(lon.controller.text),
        lat: double.parse(lat.controller.text),
      ),
      details: description.controller.text,
      url: 'https://republica-dominikana.ru/wp-content/uploads/2018/08/51.jpg',
      type: sightType.value,
    );

    await sightInteractor.addNewSight(newSight);
    navigator.pop();
  }

  // Добавление фотографии
  Future<void> _onAddPhoto(_) async {
    final SightPhoto sightPhoto = await showDialog(
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

  // Нажата кнопка "назад"
  void _onBackPressed(_) => navigator.pop();
}

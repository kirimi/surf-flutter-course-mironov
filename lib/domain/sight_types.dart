import 'package:places/domain/sight_type.dart';
import 'package:places/ui/res/svg_icons/svg_icons.dart';

/// Предустановленные категории мест, используются в фильтре.
final List<SightType> defaultSightTypes = [
  const SightType(
    name: 'Кинотеатр',
    iconName: 'cinema',
  ),
  const SightType(
    name: 'Ресторан',
    iconName: 'restaurant',
  ),
  const SightType(
    name: 'Особое место',
    iconName: 'special',
  ),
  const SightType(
    name: 'Парк',
    iconName: 'park',
  ),
  const SightType(
    name: 'Музей',
    iconName: 'museum',
  ),
  const SightType(
    name: 'Кафе',
    iconName: 'cafe',
  ),
];

/// Функция возвращает [IconData] по имени [iconName] иконки,
/// если нет такой, то иконку по-умолчанию
SvgData getIconByName(String iconName) {
  SvgData icon;
  switch (iconName) {
    case 'cinema':
      icon = SvgIcons.hotel;
      break;
    case 'restaurant':
      icon = SvgIcons.restaurant;
      break;
    case 'special':
      icon = SvgIcons.place;
      break;
    case 'park':
      icon = SvgIcons.park;
      break;
    case 'museum':
      icon = SvgIcons.museum;
      break;
    case 'cafe':
      icon = SvgIcons.cafe;
      break;
    default:
      icon = SvgIcons.info;
  }
  return icon;
}

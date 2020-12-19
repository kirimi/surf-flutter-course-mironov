/// Категория места
///
/// [iconName] сделан строкой, чтобы данные не зависели от фреймворка.
/// Преобразование iconName в IconData в [getIconByName]
/// SightType.name должен совпадать с Sight.type,
/// Добавил бы сюда int id, и в Sight изменил type на int, но скорее всего в api
/// возвращается строка в type, поэтому пока так.
class SightType {
  final String name;
  final String iconName;

  const SightType({this.name, this.iconName});
}

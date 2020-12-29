/// Категория места
///
/// [iconName] сделан строкой, чтобы данные не зависели от фреймворка.
/// Преобразование iconName в IconData в [getIconByName]
/// SightType.name должен совпадать с Sight.type,
class SightType {
  final String name;
  final String iconName;

  const SightType({this.name, this.iconName});
}

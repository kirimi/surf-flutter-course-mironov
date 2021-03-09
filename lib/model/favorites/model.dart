import 'package:mwwm/mwwm.dart';

/// Model для функции Favorite на разных экранах
/// передается по дереву с помощью Provider
class FavoritesModel extends Model {
  FavoritesModel(List<Performer<dynamic, Change>> performers)
      : super(performers);
}

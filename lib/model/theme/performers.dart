import 'package:mwwm/mwwm.dart';
import 'package:places/interactor/theme_interactor.dart';
import 'package:places/model/theme/changes.dart';

/// Получает флаг темной темы
class GetDarkModePerformer extends FuturePerformer<bool, GetDarkMode> {
  final ThemeInteractor themeInteractor;

  GetDarkModePerformer(this.themeInteractor);

  @override
  Future<bool> perform(GetDarkMode change) {
    return Future.value(themeInteractor.isDark);
  }
}

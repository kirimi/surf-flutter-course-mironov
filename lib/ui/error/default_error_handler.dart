import 'package:mwwm/mwwm.dart';

/// Обработчик ошибок для mwwm
class DefaultErrorHandler extends ErrorHandler {
  @override
  void handleError(Object e) {
    print('Error: $e');
  }
}

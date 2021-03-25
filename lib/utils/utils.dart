import 'dart:math';

/// Округляет <double>[value] до [places] знаков после запятой
double roundDouble(double value, int places) {
  double mod = pow(10.0, places).toDouble();
  return ((value * mod).round().toDouble() / mod);
}

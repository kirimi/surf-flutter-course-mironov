import 'package:flutter/scheduler.dart';

/// TickerProvider для анимации
class AppTickerProvider extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}

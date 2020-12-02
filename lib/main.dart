import 'package:flutter/material.dart';

// Если переименовать main.dart в start.dart, то при запуске `flutter run` ошибка 'Target file "lib/main.dart" not found.'
// Фреймворк ожидает что функция main() находится в файле main.dart
//
// Значение поле title виджета MaterialApp в андроиде выводится когда пользователь нажимает "recent apps".
//
// Функцию которая возвращает context.runtimeType в stateless-виджете не получится реализовать.
// Т.к. context доступен после того, как виджет вставится в дерево и запустится build. А build уже есть context.
//
// А вот в stateful-виджете context доступен из state. Доступен в виде поля стейта, ну и он же в параметре build().
// Потому, что виджет уже вставлен в дерево и state к нему привязан.
// сontext привязывается перед initState. Но в initState() не рекомендуется его использовать.
// Можно в didChangeDependencies().
// Вот тут до конца не разобрался почему в initState нельзя. Почему тут нет BuildContext.inheritFromWidgetOfExactType.
// И что происходит между initState и didChangeDependencies? Возможно это будет дальше в нашей программе.

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Places',
      home: MyFirstStatefulWidget(),
    );
  }
}

// ------------------------------------
class MyFirstStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Hello'),
    );
  }

  // нету context тут

  // getContextRuntimeType() {
  //   return context.runtimeType;
  // }
}

// -------------------------------------

class MyFirstStatefulWidget extends StatefulWidget {
  @override
  _MyFirstStatefulWidgetState createState() => _MyFirstStatefulWidgetState();
}

class _MyFirstStatefulWidgetState extends State<MyFirstStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    print(getContextRuntimeType());
    return Center(
      child: Text('Hello!'),
    );
  }

  getContextRuntimeType() {
    return context.runtimeType;
  }
}

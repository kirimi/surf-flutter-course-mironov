import 'package:flutter/material.dart';

// Задача вывести счетчик вызовов build у stateless и stateful виджетах при hotreload

// В данном коде счетчик вызовов build при hotreload будет одинаковый и в stateless и в stateful виджетах,
// но по разным причинам.
// В stateless - build вызывается при полном пересоздании виджета. constructor -> build
// В stateful - после hotreload виджет тоже пересоздается, но его state остается. А build вызывается после didUpdateWidget

// немножко расширил чтобы одновременно выводился результат

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyFirstStatelessWidget(),
            MyFirstStatefulWidget(),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------
int statelessBuildCount = 0;

class MyFirstStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    statelessBuildCount++;
    print('stateless build count: $statelessBuildCount');
    return Center(
      child: Text('stless $statelessBuildCount'),
    );
  }
}

// -------------------------------------

class MyFirstStatefulWidget extends StatefulWidget {
  @override
  _MyFirstStatefulWidgetState createState() => _MyFirstStatefulWidgetState();
}

class _MyFirstStatefulWidgetState extends State<MyFirstStatefulWidget> {
  int statefulBuildCount = 0;

  @override
  void didUpdateWidget(covariant MyFirstStatefulWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
  }

  @override
  Widget build(BuildContext context) {
    statefulBuildCount++;
    print('stateful build count: $statefulBuildCount');
    return Center(
      child: Text('stful $statefulBuildCount'),
    );
  }
}

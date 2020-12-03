import 'package:flutter/material.dart';

// Макет в фигме и описание задания немного отличаются.
// В макете только первая буква меняет цвет. Так и сделал.

class SightListScreen extends StatefulWidget {
  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // чтобы на ios title не прыгнул в центр
        centerTitle: false,
        toolbarHeight: 112.0,
        title: RichText(
          textAlign: TextAlign.left,
          maxLines: 2,
          text: TextSpan(
            style: _appBarStyle,
            children: [
              TextSpan(text: 'С', style: TextStyle(color: Colors.green)),
              TextSpan(text: 'писок\n'),
              TextSpan(text: 'и', style: TextStyle(color: Colors.yellow)),
              TextSpan(text: 'нтересных мест'),
            ],
          ),
        ),

        // делаем прозрачным чтобы был цвет фона
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}

const _appBarStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w700,
  fontSize: 32.0,
  height: 36.0 / 32.0,
);

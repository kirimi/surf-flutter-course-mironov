import 'package:flutter/material.dart';

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
        title: Text(
          'Список\nинтересных мест',
          textAlign: TextAlign.left,
          maxLines: 2,
          style: _appBarStyle,
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

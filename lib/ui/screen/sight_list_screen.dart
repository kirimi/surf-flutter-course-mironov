import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/sight_card.dart';

class SightListScreen extends StatefulWidget {
  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: 112.0,
        title: Text(
          'Список\nинтересных мест',
          textAlign: TextAlign.left,
          maxLines: 2,
          style: _appBarStyle,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SightCard(sight: mocks[0]),
              SizedBox(height: 16.0),
              SightCard(sight: mocks[1]),
              SizedBox(height: 16.0),
              SightCard(sight: mocks[2]),
              SizedBox(height: 16.0),
              SightCard(sight: mocks[3]),
              SizedBox(height: 16.0),
              SightCard(sight: mocks[4]),
            ],
          ),
        ),
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

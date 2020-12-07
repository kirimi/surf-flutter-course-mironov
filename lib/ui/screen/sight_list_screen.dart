import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_strings.dart';
import 'package:places/ui/res/app_text_styles.dart';
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
          AppStrings.sightListAppBar,
          textAlign: TextAlign.left,
          maxLines: 2,
          style: AppTextStyles.sightListAppBar,
        ),
        backgroundColor: AppColors.transparent,
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

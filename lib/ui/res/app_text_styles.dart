import 'package:flutter/material.dart';
import 'package:places/ui/res/app_colors.dart';

class AppTextStyles {
  // VisitingScreen
  // ---------------------------------------------
  static const visitingAppBarTitle = TextStyle(
    color: AppColors.grayBlue2,
    fontWeight: FontWeight.w500,
    fontSize: 18.0,
    height: 18.0 / 24.0,
  );

  static const visitingTab = TextStyle(
    color: AppColors.lightGray,
    fontWeight: FontWeight.w700,
    fontSize: 14.0,
    height: 14.0 / 18.0,
  );

  static const visitingActiveTab = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w700,
    fontSize: 14.0,
    height: 14.0 / 18.0,
  );

  //  SightList text styles
  // ---------------------------------------------

  static const sightListAppBar = TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.w700,
    fontSize: 32.0,
    height: 36.0 / 32.0,
  );

  //  SightDetails text styles
  // ---------------------------------------------

  static const sightDetailsTitle = TextStyle(
    color: AppColors.grayBlue,
    fontWeight: FontWeight.w700,
    fontSize: 24.0,
    height: 28.0 / 24.0,
  );

  static const sightDetailsDetails = TextStyle(
    color: AppColors.grayBlue,
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    height: 18.0 / 14.0,
  );

  static const sightDetailsType = TextStyle(
    color: AppColors.grayBlue,
    fontWeight: FontWeight.w700,
    fontSize: 14.0,
    height: 18.0 / 14.0,
  );

  static const sightDetailsBtn = TextStyle(
    color: AppColors.grayBlue,
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    letterSpacing: 0.3,
    height: 18.0 / 14.0,
  );

  //  SightCard text styles
  // ---------------------------------------------

  static const sightCardTitle = TextStyle(
    color: AppColors.grayBlue,
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
    height: 20.0 / 16.0,
  );

  static const sightCardDetails = TextStyle(
    color: AppColors.lightGray,
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    height: 18.0 / 14.0,
  );

  static const sightCardType = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w700,
    fontSize: 14.0,
    height: 18.0 / 14.0,
  );

  // BigButton text styles
  // ---------------------------------------------

  static const bigButtonText = TextStyle(
    color: AppColors.grayBlue,
    fontWeight: FontWeight.w700,
    fontSize: 14.0,
    letterSpacing: 0.3,
    height: 18.0 / 14.0,
  );
}

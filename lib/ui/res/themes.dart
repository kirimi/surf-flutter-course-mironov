import 'package:flutter/material.dart';
import 'package:places/ui/res/app_colors.dart';
import 'package:places/ui/res/app_text_styles.dart';

final lightTheme = ThemeData.light().copyWith(
  primaryColor: AppColors.ltPrimaryColor,
  accentColor: AppColors.ltAccentColor,
  disabledColor: AppColors.ltDisabledColor,
  cardColor: AppColors.ltCardColor,
  backgroundColor: AppColors.ltBackgroundColor,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.ltAccentColor,
    foregroundColor: AppColors.ltBackgroundColor,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.ltBottomNavBackgroundColor,
    unselectedItemColor: AppColors.ltBottomNavUnselectedColor,
    selectedItemColor: AppColors.ltBottomNavSelectedColor,
  ),
  appBarTheme: AppBarTheme(
    brightness: Brightness.dark,
    centerTitle: true,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: AppTextStyles.bigButtonText,
      primary: AppColors.ltAccentColor,
      minimumSize: Size.fromHeight(48.0),
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: AppColors.ltPrimaryColor,
      textStyle: AppTextStyles.sightDetailsBtn,
    ),
  ),
);

final darkTheme = ThemeData.dark().copyWith(
  primaryColor: AppColors.dkPrimaryColor,
  accentColor: AppColors.dkAccentColor,
  disabledColor: AppColors.dkDisabledColor,
  cardColor: AppColors.dkCardColor,
  backgroundColor: AppColors.dkBackgroundColor,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.dkAccentColor,
    foregroundColor: AppColors.dkBackgroundColor,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.dkBottomNavBackgroundColor,
    unselectedItemColor: AppColors.dkBottomNavUnselectedColor,
    selectedItemColor: AppColors.dkBottomNavSelectedColor,
  ),
  appBarTheme: AppBarTheme(
    brightness: Brightness.dark,
    centerTitle: true,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: AppTextStyles.bigButtonText,
      primary: AppColors.dkAccentColor,
      minimumSize: Size.fromHeight(48.0),
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: AppColors.dkPrimaryColor,
      textStyle: AppTextStyles.sightDetailsBtn,
    ),
  ),
);

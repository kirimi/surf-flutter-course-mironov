import 'package:flutter/material.dart';
import 'package:places/ui/res/app_colors.dart';

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
);

final darkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
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
);

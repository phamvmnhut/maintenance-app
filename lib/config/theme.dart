import 'package:divice/config/color.dart';
import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.green,
  errorColor: AppColors.orangeColor,
  backgroundColor: Colors.white,
  primaryColor: AppColors.greenColor,
  cardColor: AppColors.grayColor2,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.green,
  errorColor: AppColors.orangeColor,
  backgroundColor: Colors.black,
  primaryColor: AppColors.greenColor,
);

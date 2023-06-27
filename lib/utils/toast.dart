import 'package:maintenance/config/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

toastInfo({
  required String msg,
  Color textColor = Colors.white,
  Color backgroundColor = Colors.redAccent,
}) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    textColor: textColor,
    backgroundColor: backgroundColor,
  );
}

class ToastType {
  static Future<bool?> toastError({required String msg}) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      textColor: Colors.white,
      backgroundColor: AppColors.orangeColor,
    );
  }

  static Future<bool?> toastInfo({required String msg}) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      textColor: Colors.white,
      backgroundColor: AppColors.blueColor,
    );
  }

  static Future<bool?> toastWarning({required String msg}) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      textColor: Colors.white,
      backgroundColor: AppColors.redColor,
    );
  }
}

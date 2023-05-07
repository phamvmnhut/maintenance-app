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

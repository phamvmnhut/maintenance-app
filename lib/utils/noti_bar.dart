import 'package:flutter/material.dart';
import '../../config/status.dart';
import '../../config/color.dart';

class NotiBar {
  static void showSnackBar(BuildContext context, String text,
      {NotificationStatusEnum? status}) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        backgroundColor: status == null
            ? AppColors.blueColor
            : status == NotificationStatusEnum.success
                ? AppColors.greenColor
                : status == NotificationStatusEnum.warning
                    ? AppColors.orangeColor
                    : AppColors.redColor,
        content: Text(text),
      ));
  }
}


import 'package:maintenance/config/color.dart';
import 'package:flutter/material.dart';


Future<bool?> alertDialogDeleteApp(BuildContext context) async {
  bool? result;
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Warning!'),
        content: const Text('Do you really want to delete?'),
        actions: [
          TextButton(
              onPressed: () {
                result = true;
                Navigator.pop(context);
              },
              child: Text(
                'Confirm',
                style: TextStyle(
                  color: AppColors.redColor,
                ),
              )),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'))
        ],
      );
    },
  );
  return result;
}

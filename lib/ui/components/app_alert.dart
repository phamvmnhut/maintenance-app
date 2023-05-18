import 'package:maintenance/config/color.dart';
import 'package:flutter/material.dart';
import 'package:maintenance/generated/l10n.dart';

Future<bool?> alertDialogDeleteApp(BuildContext context) async {
  bool? result;
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(S.of(context).warning),
        content: Text(S.of(context).msg_delete),
        actions: [
          TextButton(
              onPressed: () {
                result = true;
                Navigator.pop(context);
              },
              child: Text(
                S.of(context).confirm,
                style: TextStyle(
                  color: AppColors.redColor,
                ),
              )),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(S.of(context).cancel))
        ],
      );
    },
  );
  return result;
}

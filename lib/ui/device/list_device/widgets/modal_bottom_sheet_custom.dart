import 'package:maintenance/config/color.dart';
import 'package:flutter/material.dart';
import 'package:maintenance/generated/l10n.dart';

Future<String?> addOrUpdateModal(BuildContext context,
    {String hintText = '', String stringInput = ''}) async {
  String? result;
  final textController = TextEditingController();
  textController.text = stringInput;
  await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            color: Theme.of(context).canvasColor,
            alignment: Alignment.topCenter,
            height: 160,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  height: 48,
                  width: MediaQuery.of(context).size.width * 0.75,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Theme.of(context).cardColor),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: hintText,
                        border: InputBorder.none,
                        prefixIcon:
                            const Icon(Icons.format_color_text_rounded)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.greenColor),
                        onPressed: () {
                          if (textController.text.isNotEmpty) {
                            result = textController.text;
                            Navigator.pop(context);
                          }
                        },
                        child: Text(S.of(context).save)),
                    const SizedBox(width: 20),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.redColor),
                        onPressed: stringInput.isNotEmpty
                            ? () async {
                                await alertDialogDelete(context).then((value) {
                                  if (value != null) {
                                    result = value;
                                    Navigator.pop(context);
                                  }
                                });
                              }
                            : null,
                        child: Text(S.of(context).delete)),
                  ],
                ),
              ],
            ),
          ),
        );
      });
  return result;
}

Future<String?> alertDialogDelete(BuildContext context) async {
  String? result;
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(S.of(context).warning),
        content: Text(S.of(context).msg_delete),
        actions: [
          TextButton(
              onPressed: () {
                result = 'isDelete';
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

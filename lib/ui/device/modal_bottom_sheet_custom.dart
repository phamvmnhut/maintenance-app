import 'package:flutter/material.dart';

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
            color: Colors.white,
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
                      color: const Color(0xFFF8F8F6)),
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
                            backgroundColor: const Color(0xFF53C052)),
                        onPressed: () {
                          if (textController.text.isNotEmpty) {
                            result = textController.text;
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Lưu')),
                    const SizedBox(width: 20),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE43237)),
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
                        child: const Text('Xóa')),
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
        title: const Text('Warning!'),
        content: const Text('Do you really want to delete?'),
        actions: [
          TextButton(
              onPressed: () {
                result = 'isDelete';
                Navigator.pop(context);
              },
              child: const Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.red,
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

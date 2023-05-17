import 'package:maintenance/business/auth.dart';
import 'package:maintenance/config/color.dart';
import 'package:maintenance/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> profileUpdateUsernameBottomSheet(
  BuildContext contextx,
  String oldName,
) async {
  final textController = TextEditingController();
  textController.text = oldName;
  await showModalBottomSheet(
      isScrollControlled: true,
      context: contextx,
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
                    textCapitalization: TextCapitalization.sentences,
                    textAlignVertical: TextAlignVertical.center,
                    controller: textController,
                    decoration: const InputDecoration(
                        hintText: "Update check today",
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.format_color_text_rounded)),
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
                            BlocProvider.of<AuthBloc>(contextx, listen: false)
                                .add(AuthEventUpdateUser(
                                    newName: textController.text));
                            Navigator.pop(context);
                          }
                        },
                        child: Text(S.of(context).save)),
                    const SizedBox(width: 20),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.grayColor),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(S.of(context).cancel)),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}

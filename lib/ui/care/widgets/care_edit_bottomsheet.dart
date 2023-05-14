import 'package:divice/config/color.dart';
import 'package:divice/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business/care_detail.dart';
import '../../../domain/entities/care.dart';

Future<void> careEditBottomSheet(
  BuildContext contextx,
  Care care,
) async {
  final careNametextController = TextEditingController();
  careNametextController.text = care.memo_name;
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
                    controller: careNametextController,
                    decoration: const InputDecoration(
                        hintText: "Update today",
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
                          if (careNametextController.text.isNotEmpty) {
                            BlocProvider.of<CareDetailBloc>(contextx,
                                    listen: false)
                                .add(CareDetailEventUpdateCare(
                              memo_name: careNametextController.text,
                            ));
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

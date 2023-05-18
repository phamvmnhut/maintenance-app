import 'package:maintenance/config/color.dart';
import 'package:maintenance/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business/care_detail.dart';
import '../../../domain/entities/care_history.dart';

Future<void> careHistoryEditOrDeleteBottomSheet(
  BuildContext contextx,
  CareHistory history,
) async {
  final textController = TextEditingController();
  textController.text = history.memo;
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
                    decoration: InputDecoration(
                        hintText: S.of(context).care_history_hint,
                        border: InputBorder.none,
                        prefixIcon: const Icon(Icons.format_color_text_rounded)),
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
                            BlocProvider.of<CareDetailBloc>(contextx,
                                    listen: false)
                                .add(
                              CareDetailEventUpdateHistory(
                                history:
                                    history.copyWith(memo: textController.text),
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: Text(S.of(context).save)),
                    const SizedBox(width: 20),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.redColor),
                        onPressed: () {
                          BlocProvider.of<CareDetailBloc>(contextx,
                                  listen: false)
                              .add(
                            CareDetailEventDeleteHistory(
                              history: history,
                            ),
                          );
                          Navigator.pop(context);
                        },
                        child: Text(S.of(context).delete)),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}

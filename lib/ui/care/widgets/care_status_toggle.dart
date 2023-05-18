import 'package:maintenance/business/care_detail.dart';
import 'package:maintenance/domain/entities/care.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/color.dart';

class CareStatusToggle extends StatefulWidget {
  const CareStatusToggle({Key? key, required this.status}) : super(key: key);
  final String status;
  @override
  State<CareStatusToggle> createState() => _CareStatusToggleState();
}

class _CareStatusToggleState extends State<CareStatusToggle> {
  List<bool> isSelected = [false, false, false];

  @override
  void initState() {
    super.initState();

    isSelected = CareStatus.Status()
        .map(
          (e) => e == widget.status,
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Theme.of(context).cardColor,
      ),
      child: ToggleButtons(
        isSelected: isSelected,
        color: Theme.of(context).cardColor,
        renderBorder: false,
        borderRadius: BorderRadius.circular(12),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 30,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: AppColors.blueColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 30,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: AppColors.greenColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 30,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: AppColors.redColor),
            ),
          ),
        ],
        onPressed: (int newIndex) {
          setState(() {
            // looping through the list of booleans values
            for (int index = 0; index < isSelected.length; index++) {
              // checking for the index value
              if (index == newIndex) {
                // one button is always set to true
                isSelected[index] = true;
              } else {
                // other two will be set to false and not selected
                isSelected[index] = false;
              }
            }
            BlocProvider.of<CareDetailBloc>(context, listen: false).add(
              CareDetailEventUpdateCare(
                status: CareStatus.indexToStatus(newIndex),
              ),
            );
          });
        },
      ),
    );
  }
}

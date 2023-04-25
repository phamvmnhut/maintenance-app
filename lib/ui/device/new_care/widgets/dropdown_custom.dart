import 'package:divice/config/color.dart';
import 'package:flutter/material.dart';

class DropdownDeviceCustom extends StatelessWidget {
  final Widget image;
  final String text;
  final bool isDropdown;
  final bool isSmall;
  final Function() func;
  const DropdownDeviceCustom({
    Key? key,
    required this.text,
    required this.image,
    this.isDropdown = false,
    this.isSmall = false,
    required this.func,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double paddingLeft = isSmall ? 24 : 18;
    double paddingRight = isSmall ? 14 : 9;
    return Container(
        padding: EdgeInsets.only(left: paddingLeft, right: 21),
        height: 48,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Theme.of(context).cardColor),
        child: InkWell(
          onTap: func,
          child: Row(
            children: [
              image,
              SizedBox(width: paddingRight),
              Expanded(
                child: Text(text,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500)),
              ),
              isDropdown
                  ? Icon(Icons.arrow_drop_down_rounded,
                      color: AppColors.grayColor, size: 15)
                  : const SizedBox()
            ],
          ),
        ));
  }
}

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
            color: const Color(0xFFF8F8F7)),
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
                  ? const Icon(Icons.arrow_drop_down_rounded,
                      color: Color(0xFF9B9B9B), size: 15)
                  : const SizedBox()
            ],
          ),
        ));
  }
}

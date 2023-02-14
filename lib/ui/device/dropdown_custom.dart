import 'package:flutter/material.dart';

class DropdownDeviceCustom extends StatelessWidget {
  final Widget image;
  final String text;
  final bool isDropdown;
  final Function() func;
  const DropdownDeviceCustom(
      {Key? key,
      required this.text,
      required this.func,
      required this.image,
      required this.isDropdown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 18, right: 21),
        height: 48,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: const Color(0xFFF8F8F7)),
        child: InkWell(
          onTap: func,
          child: Row(
            children: [
              image,
              const SizedBox(width: 9),
              Expanded(
                  child: Text(
                text,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              )),
              isDropdown
                  ? const Icon(
                      Icons.arrow_drop_down_rounded,
                      color: Color(0xFF9B9B9B),
                      size: 15,
                    )
                  : const SizedBox()
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';

class AddNewCare extends StatelessWidget {
  const AddNewCare({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 52),
              child: Container(
                padding: const EdgeInsets.all(16),
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F6),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.arrow_back_sharp,
                  size: 16.0,
                  color: Color(0xFF9B9B9B),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 32),
              child: Text(
                'Add new device care',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, right: 40.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Device', style: TextStyle(fontSize: 15)),
                  Image.asset('assets/images/icon_qr.png')
                ],
              ),
            ),
            DropdownDevice(
              text: 'Điện thoại | Iphone 14',
              image: Image.asset('assets/images/drugs.png'),
              func: (value) {},
            ),
            const SizedBox(height: 12),
            DropdownDevice(
              text: 'Màn hình',
              image: const Icon(Icons.format_list_numbered_rounded),
              func: (value) {},
            ),
            const SizedBox(height: 10),
            const Text('Memo name', style: TextStyle(fontSize: 15)),
            const SizedBox(height: 4),
            DropdownDevice(
              text: 'Bảo hành màn hình đt',
              image: const Icon(Icons.more_horiz_sharp),
              func: (value) {},
            ),
            const SizedBox(height: 18),
            const Text('Notification', style: TextStyle(fontSize: 15)),
          ],
        ),
      )),
    );
  }
}

class DropdownDevice extends StatelessWidget {
  final String text;
  final Function(String?) func;
  final Widget image;
  const DropdownDevice({
    Key? key,
    required this.text,
    required this.func,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 319,
        height: 48,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: const Color(0xFFF8F8F7)),
        child: DropdownButtonFormField(
          isExpanded: true,
          decoration: InputDecoration(
              border: InputBorder.none,
              icon: const Icon(
                Icons.arrow_drop_down,
                size: 5,
              ),
              prefixIcon: image),
          hint: Text(text),
          items: ['A', 'B', 'C', 'D'].map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: func,
        ));
  }
}

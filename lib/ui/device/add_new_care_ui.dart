import 'package:flutter/material.dart';
import 'dropdown_custom.dart';

class AddNewCare extends StatelessWidget {
  const AddNewCare({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 28, right: 28),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 52),
              Container(
                alignment: Alignment.center,
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
              const SizedBox(height: 32),
              Container(
                height: 38,
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Add new device care',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.only(right: 12.5),
                height: 38,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Device',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    Image.asset(
                      'assets/images/icon_qr.png',
                      width: 14,
                      height: 14,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 4),
              DropdownDeviceCustom(
                text: 'Điện thoại | Iphone 14',
                image: Image.asset('assets/images/drugs.png'),
                isDropdown: true,
                func: () {},
              ),
              const SizedBox(height: 8),
              DropdownDeviceCustom(
                text: 'Màn hình',
                image: const Icon(
                  Icons.format_list_bulleted_sharp,
                  size: 14,
                ),
                isDropdown: true,
                func: () {},
              ),
              const SizedBox(height: 10),
              Container(
                height: 38,
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Memo name',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 4),
              DropdownDeviceCustom(
                text: 'Bảo hành màn hình đt',
                image: const Icon(
                  Icons.more_horiz_sharp,
                  size: 14,
                ),
                isDropdown: false,
                func: () {},
              ),
              const SizedBox(height: 18),
              const Text(
                'Notification',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 14.0),
                child: Text(
                  'Start Date',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: DropdownDeviceCustom(
                      text: '  21/12/2022',
                      image:
                          const Icon(Icons.calendar_month_outlined, size: 14),
                      isDropdown: false,
                      func: () {},
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    flex: 1,
                    child: DropdownDeviceCustom(
                      text: '   10:00 AM',
                      image: const Icon(Icons.more_time_sharp, size: 14),
                      isDropdown: false,
                      func: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: DropdownDeviceCustom(
                      text: '  One Time',
                      image: const Icon(Icons.av_timer_outlined, size: 14),
                      isDropdown: true,
                      func: () {},
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    flex: 1,
                    child: DropdownDeviceCustom(
                      text: '   30   days',
                      image: const Icon(Icons.wallet_travel_rounded, size: 14),
                      isDropdown: true,
                      func: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 17),
              Container(
                height: 38,
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Information',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: (() {}),
                child: Image.asset('assets/images/upload_image.png'),
              ),
              const SizedBox(height: 27),
              GestureDetector(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: const Color(0xFF1BD15D),
                  ),
                  child: const Text('Xong',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: Colors.white)),
                ),
              ),
              const SizedBox(height: 26)
            ],
          ),
        ),
      )),
    );
  }
}

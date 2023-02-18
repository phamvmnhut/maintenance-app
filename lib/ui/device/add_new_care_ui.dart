import 'dart:convert';

import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'dropdown_custom.dart';
import 'package:intl/intl.dart';

class AddNewCare extends StatefulWidget {
  const AddNewCare({super.key});

  @override
  State<AddNewCare> createState() => _AddNewCareState();
}

class _AddNewCareState extends State<AddNewCare> {
  String _device = 'Điện thoại | iPhone 14';
  String _deviceDetail = 'Màn hình';
  String _memo = 'Bảo hành màn hình đt';
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay(
    hour: DateTime.now().hour,
    minute: DateTime.now().minute,
  );
  String _timeReturn = 'One Time';
  List<DeviceModel> _listDeviceModel = [];

  @override
  void initState() {
    super.initState();
    var jsonObeject = jsonDecode(_listDeviceJson);
    _listDeviceModel = jsonObeject
        .map<DeviceModel>((json) => DeviceModel.fromJson(json))
        .toList();
  }

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
                    Image.asset('assets/images/icon_qr.png',
                        width: 14, height: 14),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              DropdownDeviceCustom(
                  text: _device,
                  image: Image.asset('assets/images/drugs.png'),
                  isDropdown: true,
                  func: () async {
                    var value =
                        await _showButtomListExpand(context, _listDeviceModel);
                    setState(() {
                      _device = value;
                    });
                  }),
              const SizedBox(height: 8),
              DropdownDeviceCustom(
                text: _deviceDetail,
                image: const Icon(Icons.format_list_bulleted_sharp, size: 14),
                isDropdown: true,
                func: () async {
                  var value = await _showButtomList(context, _listDeviceDetail);
                  setState(() {
                    _deviceDetail = value;
                  });
                },
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
                text: _memo,
                image: const Icon(Icons.more_horiz_sharp, size: 14),
                func: () async {
                  var value = await _showButtomList(context, _listMemo);
                  setState(() {
                    _memo = value;
                  });
                },
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
                      text: DateFormat('dd/MM/yyyy').format(_date).toString(),
                      image:
                          const Icon(Icons.calendar_month_outlined, size: 14),
                      isSmall: true,
                      func: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(DateTime.now().year - 2),
                          lastDate: DateTime(DateTime.now().year + 2),
                        );
                        if (picked != null && picked != _date) {
                          setState(() {
                            _date = picked;
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    flex: 1,
                    child: DropdownDeviceCustom(
                      text: _time.format(context).toString(),
                      image: const Icon(Icons.more_time_sharp, size: 14),
                      isSmall: true,
                      func: () async {
                        final TimeOfDay? picker = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(
                            hour: DateTime.now().hour,
                            minute: DateTime.now().minute,
                          ),
                        );
                        if (picker != null && picker != _time) {
                          setState(() {
                            _time = picker;
                          });
                        }
                      },
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
                      text: _timeReturn,
                      image: const Icon(Icons.av_timer_outlined, size: 14),
                      isDropdown: true,
                      isSmall: true,
                      func: () async {
                        var value = await _showButtomList(context, _listTime);
                        setState(() {
                          _timeReturn = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    flex: 1,
                    child: DropdownDeviceCustom(
                      text: '30 \t\t\t days',
                      image: const Icon(Icons.wallet_travel_rounded, size: 14),
                      isDropdown: true,
                      isSmall: true,
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
                onTap: () async {},
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
              const SizedBox(height: 26),
            ],
          ),
        ),
      )),
    );
  }
}

Future<String> _showButtomListExpand(
    BuildContext context, List<DeviceModel> listDeviceDetail) async {
  String result = '';
  await showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          children: listDeviceDetail.map((value) {
            return ExpansionTile(
              title: Text(value.device!),
              leading: const Icon(Icons.devices_other_sharp),
              children: value.deviceDetail!.map((e) {
                return ListTile(
                    title: Text(e.name!),
                    onTap: () {
                      result = '${value.device!} | ${e.name!}';
                      Navigator.pop(context);
                    });
              }).toList(),
            );
          }).toList(),
        );
      });
  return result;
}

Future<String> _showButtomList(BuildContext context, List<String> list) async {
  String result = '';
  await showModalBottomSheet(
      context: context,
      builder: (_) {
        return ListView(
          children: list.map((value) {
            return ListTile(
              title: Text(value),
              onTap: () {
                result = value;
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      });
  return result;
}

List<String> _listDeviceDetail = [
  'Màn hình',
  'Bàn phím',
  'Loa ngoài',
];
List<String> _listMemo = [
  'Bảo hành màn hình đt',
  'Bảo hành bàn phím',
  'Bảo hành loa ngoài',
];
List<String> _listTime = [
  'One Time',
  'Two Time',
  'Three Time',
];
var _listDeviceJson = '''
[
    {
        "device": "Điện thoại",
        "device_detail": [
            {
                "name": "iPhone 14"
            },
            {
                "name": "iPhone 14 Pro Max"
            },
            {
                "name": "Samsung"
            }
        ]
    },
    {
        "device": "Máy tính",
        "device_detail": [
            {
                "name": "Máy tính bàn"
            },
            {
                "name": "Máy tính xách tay"
            },
            {
                "name": "Máy tính đồng bộ"
            }
        ]
    }
]
''';

class DeviceModel {
  String? device;
  List<DeviceDetail>? deviceDetail;

  DeviceModel({this.device, this.deviceDetail});

  DeviceModel.fromJson(Map<String, dynamic> json) {
    device = json['device'];
    if (json['device_detail'] != null) {
      deviceDetail = <DeviceDetail>[];
      json['device_detail'].forEach((v) {
        deviceDetail!.add(DeviceDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['device'] = device;
    if (deviceDetail != null) {
      data['device_detail'] = deviceDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DeviceDetail {
  String? name;

  DeviceDetail({this.name});

  DeviceDetail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

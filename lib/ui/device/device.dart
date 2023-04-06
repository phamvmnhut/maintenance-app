import 'package:divice/business/device.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/device.dart';
import 'device_detail.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({Key? key}) : super(key: key);

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    BlocProvider.of<DeviceBloc>(context, listen: false)
        .add(DeviceEventGetList());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<DeviceBloc, DeviceState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(left: 23, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 41),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Device List',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 21),

                    //Container 1 device
                    ListDeviceDetail(
                      lstDevice: state.list,
                    ),

                    GestureDetector(
                      onTap: () async {
                        await addDevice(context).then((value) {
                          if (value != null) {
                            BlocProvider.of<DeviceBloc>(context, listen: false)
                                .add(DeviceEventAddDevice(deviceName: value));
                            BlocProvider.of<DeviceBloc>(context, listen: false)
                                .add(DeviceEventGetList());
                          }
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: const Color(0xFF1BD15D),
                        ),
                        child: const Text('Thêm mới',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Future<String?> addDevice(BuildContext context) async {
  String? device;
  final deviceController = TextEditingController();
  await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            alignment: Alignment.topCenter,
            height: 200,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('Device name:'),
                    const SizedBox(width: 10),
                    Expanded(
                        child: TextField(
                      controller: deviceController,
                    )),
                  ],
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4169E1)),
                    onPressed: () {
                      if (deviceController.text.isNotEmpty) {
                        device = deviceController.text;
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Lưu')),
              ],
            ),
          ),
        );
      });
  return device;
}

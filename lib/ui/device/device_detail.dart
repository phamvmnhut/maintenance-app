import 'package:divice/domain/entities/device.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/device.dart';
import '../../domain/entities/model.dart';
import 'model_container.dart';

class ListDeviceDetail extends StatelessWidget {
  final DeviceState state;
  const ListDeviceDetail({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: state.list
          .map((device) => Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: ExpansionTile(
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        expandedAlignment: Alignment.centerLeft,
                        title: Row(
                          children: [
                            Text(
                              device.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.black),
                            ),
                            const SizedBox(width: 5),
                            GestureDetector(
                                child: const Icon(Icons.edit, size: 15),
                                onTap: () async {
                                  await editDevice(context, device)
                                      .then((value) {
                                    if (value != null) {
                                      BlocProvider.of<DeviceBloc>(context,
                                              listen: false)
                                          .add(DeviceEventUpdateDevice(
                                              device: value));
                                      BlocProvider.of<DeviceBloc>(context,
                                              listen: false)
                                          .add(DeviceEventGetList());
                                    }
                                  });
                                }),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${device.count} models',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: Color(0xFF9B9B9B))),
                            const Divider(color: Colors.black),
                          ],
                        ),
                        children: [
                          ModelContainer(deviceID: device.id),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF1BD15D)),
                                onPressed: () async {
                                  await addModel(context, device.id)
                                      .then((value) {
                                    if (value != null) {
                                      BlocProvider.of<DeviceBloc>(context,
                                              listen: false)
                                          .add(DeviceEventAddModel(
                                              modelName: value.name,
                                              deviceId: value.device_id));
                                      BlocProvider.of<DeviceBloc>(context,
                                              listen: false)
                                          .add(DeviceEventGetList());
                                    }
                                  });
                                },
                                child: const Text('Thêm mới')),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                ],
              ))
          .toList(),
    );
  }
}

Future<Model?> addModel(BuildContext context, String deviceID) async {
  Model? model;
  final modelController = TextEditingController();
  await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          alignment: Alignment.topCenter,
          height: 200,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  const Text('Model name:'),
                  const SizedBox(width: 10),
                  Expanded(
                      child: TextField(
                    controller: modelController,
                  )),
                ],
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4169E1)),
                  onPressed: () {
                    model = Model(
                        name: modelController.text,
                        id: '',
                        device_id: deviceID,
                        count: 0);
                    Navigator.pop(context);
                  },
                  child: const Text('Lưu')),
            ],
          ),
        );
      });
  return model;
}

Future<Device?> editDevice(BuildContext context, Device device) async {
  Device? newDevice;
  final deviceController = TextEditingController();
  deviceController.text = device.name;
  await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          alignment: Alignment.topCenter,
          height: 200,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  const Text('Model name:'),
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
                      newDevice = Device(
                          name: deviceController.text, id: device.id, count: 1);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Lưu')),
            ],
          ),
        );
      });
  return newDevice;
}

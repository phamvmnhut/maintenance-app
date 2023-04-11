import 'package:divice/domain/entities/device.dart';
import 'package:divice/ui/device/modal_bottom_sheet_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business/device.dart';
import 'model_container.dart';

class ListDeviceDetail extends StatefulWidget {
  final List<Device> lstDevice;
  const ListDeviceDetail({
    super.key,
    required this.lstDevice,
  });

  @override
  State<ListDeviceDetail> createState() => _ListDeviceDetailState();
}

class _ListDeviceDetailState extends State<ListDeviceDetail> {
  @override
  void didChangeDependencies() {
    BlocProvider.of<DeviceBloc>(context, listen: false)
        .add(DeviceEventGetList());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.lstDevice
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
                                  await addOrUpdateModal(
                                    context,
                                    stringInput: device.name,
                                    hintText: 'Input Device name...',
                                  ).then((value) {
                                    if (value != null) {
                                      BlocProvider.of<DeviceBloc>(
                                        context,
                                        listen: false,
                                      ).add(
                                        DeviceEventUpdateDevice(
                                          deviceId: device.id,
                                          deviceName: value,
                                        ),
                                      );
                                      BlocProvider.of<DeviceBloc>(
                                        context,
                                        listen: false,
                                      ).add(DeviceEventGetList());
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
                                  await addOrUpdateModal(
                                    context,
                                    hintText: 'Input Model name...',
                                  ).then((value) {
                                    if (value != null) {
                                      BlocProvider.of<DeviceBloc>(context,
                                              listen: false)
                                          .add(DeviceEventAddModel(
                                              modelName: value,
                                              deviceId: device.id));
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
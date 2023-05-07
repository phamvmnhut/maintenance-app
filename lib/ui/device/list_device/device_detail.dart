import 'package:divice/config/color.dart';
import 'package:divice/domain/entities/device.dart';
import 'widgets/modal_bottom_sheet_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business/device.dart';
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
  Widget build(BuildContext context) {
    return Column(
      children: widget.lstDevice
          .map((device) => Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
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
                                  fontWeight: FontWeight.w500, fontSize: 15),
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
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: AppColors.grayColor)),
                            Divider(color: AppColors.blackColor),
                          ],
                        ),
                        children: [
                          ModelContainer(deviceID: device.id),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.greenColor),
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

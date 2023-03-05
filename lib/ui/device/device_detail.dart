import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/device.dart';
import 'model_container.dart';

class ListDeviceDetail extends StatelessWidget {
  final DeviceState state;
  const ListDeviceDetail({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    print(state.list);
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
                    iconColor: Colors.black,
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
                            onTap: () {}),
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
                     children: [ModelContainer(deviceID: device.id)],
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

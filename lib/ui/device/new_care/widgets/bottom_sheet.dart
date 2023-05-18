import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business/device.dart';
import '../../../../domain/entities/equipment.dart';

Future<Map<String, String>> showButtomListExpand(
    BuildContext context, DeviceState state) async {
  Map<String, String> result = {};
  await showModalBottomSheet(
      context: context,
      builder: (context) {
        return BlocConsumer<DeviceBloc, DeviceState>(
            listener: (context, state) {},
            builder: (context, state) {
              return state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView(
                      shrinkWrap: true,
                      children: state.list.map((device) {
                        return ExpansionTile(
                          title: Text(device.name),
                          leading: const Icon(Icons.devices_other_sharp),
                          children: state.listModel[device.id]!.map((model) {
                            return ListTile(
                                title: Text(model.name),
                                onTap: () {
                                  result.addAll({device.name: model.name});
                                  result.addAll({model.id: model.name});
                                  Navigator.pop(context);
                                });
                          }).toList(),
                        );
                      }).toList(),
                    );
            });
      });
  return result;
}

Future<Equipment?> showButtomListEquipment(
    BuildContext context, List<Equipment> list) async {
  Equipment? result;
  await showModalBottomSheet(
      context: context,
      builder: (_) {
        return ListView(
          children: list.map((equipment) {
            return ListTile(
              title: Text(equipment.name),
              onTap: () {
                result = equipment;
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      });
  return result;
}
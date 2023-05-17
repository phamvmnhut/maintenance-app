// ignore_for_file: use_build_context_synchronously

import 'package:maintenance/domain/entities/device.dart';
import 'package:maintenance/domain/entities/equipment.dart';
import 'package:maintenance/domain/entities/model.dart';
import 'package:maintenance/domain/repositories/firebase/device_repository_firebase.dart';
import 'package:maintenance/domain/repositories/firebase/model_repository_firebase.dart';
import 'package:maintenance/domain/repositories/firebase/equipment_repository_firebase.dart';

import 'package:maintenance/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EquipmentData extends StatefulWidget {
  const EquipmentData({Key? key, required this.equipmentId}) : super(key: key);
  final String? equipmentId;
  @override
  State<EquipmentData> createState() => _EquipmentDataState();
}

class _EquipmentDataModel {
  final String model;
  final String equipment;
  _EquipmentDataModel({required this.model, required this.equipment});
}

class _EquipmentDataState extends State<EquipmentData> {
  Future<_EquipmentDataModel> getData(String? id) async {
    if (id == null) {
      throw FlutterError(
        'Equipment Id invalid',
      );
    }
    Equipment e =
        await RepositoryProvider.of<EquipmentRepositoryFirebase>(context)
            .get(id: id);
    Model m = await RepositoryProvider.of<ModelRepositoryFirebase>(context)
        .get(id: e.model_id);
    Device d = await RepositoryProvider.of<DeviceRepositoryFireBase>(context)
        .get(id: m.device_id);

    return _EquipmentDataModel(
        model: "${d.name} | ${m.name}", equipment: e.name);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: FutureBuilder(
        future: getData(widget.equipmentId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(snapshot.data!.model),
                Text(snapshot.data!.equipment),
              ],
            );
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).loading),
              Text(S.of(context).loading),
            ],
          );
        },
      ),
    );
  }
}

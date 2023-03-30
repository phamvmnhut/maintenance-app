import 'package:divice/domain/entities/equipment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/device.dart';

class EquipmentContainer extends StatefulWidget {
  final String modelID;
  const EquipmentContainer({
    super.key,
    required this.modelID,
  });

  @override
  State<EquipmentContainer> createState() => _EquipmentContainerState();
}

class _EquipmentContainerState extends State<EquipmentContainer> {
  @override
  void didChangeDependencies() {
    BlocProvider.of<DeviceBloc>(context, listen: false)
        .add(DeviceEventGetListEquipment(modelID: widget.modelID));

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceBloc, DeviceState>(builder: (context, state) {
      if (state.listEquipment[widget.modelID] == null) {
        return const CircularProgressIndicator();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: state.listEquipment[widget.modelID]!
                .map((equipment) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0, top: 10.0),
                          child: Row(
                            children: [
                              Text(
                                equipment.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 5),
                              GestureDetector(
                                  child: equipment.name != 'All'
                                      ? const Icon(Icons.edit, size: 15)
                                      : Container(),
                                  onTap: () async {
                                    await editEquipment(context, equipment)
                                        .then((value) {
                                      if (value != null) {
                                        BlocProvider.of<DeviceBloc>(context,
                                                listen: false)
                                            .add(DeviceEventUpdateEquipment(
                                                equipment: value));
                                        BlocProvider.of<DeviceBloc>(context,
                                                listen: false)
                                            .add(DeviceEventGetList());
                                      }
                                    });
                                  }),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 15.0, right: 56),
                          child: Divider(
                            color: Colors.black,
                          ),
                        )
                      ],
                    ))
                .toList(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1BD15D)),
                onPressed: () async {
                  await addEquipment(context, widget.modelID).then((value) {
                    if (value != null) {
                      BlocProvider.of<DeviceBloc>(context, listen: false)
                          .add(DeviceEventAddEquipment(equipment: value));
                      BlocProvider.of<DeviceBloc>(context, listen: false)
                          .add(DeviceEventGetList());
                    }
                  });
                },
                child: const Text('Thêm mới')),
          ),
        ],
      );
    });
  }
}

Future<Equipment?> addEquipment(BuildContext context, String modelID) async {
  Equipment? equipment;
  final equipmentController = TextEditingController();

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
                  const Text('Equipment name:'),
                  const SizedBox(width: 10),
                  Expanded(
                      child: TextField(
                    controller: equipmentController,
                  )),
                ],
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4169E1)),
                  onPressed: () {
                    equipment = Equipment(
                        id: '',
                        name: equipmentController.text,
                        model_id: modelID);
                    Navigator.pop(context);
                  },
                  child: const Text('Lưu')),
            ],
          ),
        );
      });
  return equipment;
}

Future<Equipment?> editEquipment(
    BuildContext context, Equipment equipment) async {
  Equipment? newEquipment;
  final equipmentController = TextEditingController();
  equipmentController.text = equipment.name;
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
                    controller: equipmentController,
                  )),
                ],
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4169E1)),
                  onPressed: () {
                    if (equipmentController.text.isNotEmpty) {
                      newEquipment = Equipment(
                          name: equipmentController.text,
                          id: equipment.id,
                          model_id: equipment.model_id);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Lưu')),
            ],
          ),
        );
      });
  return newEquipment;
}

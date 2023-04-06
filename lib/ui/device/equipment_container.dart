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
                                                equipmentId: equipment.id,
                                                equipmentName: value));
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
                          .add(DeviceEventAddEquipment(
                        modelId: widget.modelID,
                        equipmentName: value,
                      ));
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

Future<String?> addEquipment(BuildContext context, String modelID) async {
  String? equipment;
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
                    if (equipmentController.text.isNotEmpty) {
                      equipment = equipmentController.text;
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Lưu')),
            ],
          ),
        );
      });
  return equipment;
}

Future<String?> editEquipment(BuildContext context, Equipment equipment) async {
  String? newEquipment;
  final equipmentController = TextEditingController();
  equipmentController.text = equipment.name;
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
                        newEquipment = equipmentController.text;
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Lưu')),
              ],
            ),
          ),
        );
      });
  return newEquipment;
}

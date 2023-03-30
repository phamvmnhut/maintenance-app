import 'package:divice/business/device.dart';
import 'package:divice/domain/entities/model.dart';
import 'package:divice/domain/repositories/firebase/model_repository_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'equipment_container.dart';

class ModelContainer extends StatefulWidget {
  final String deviceID;
  const ModelContainer({
    super.key,
    required this.deviceID,
  });

  @override
  State<ModelContainer> createState() => _ModelContainerState();
}

class _ModelContainerState extends State<ModelContainer> {
  @override
  void didChangeDependencies() {
    BlocProvider.of<DeviceBloc>(context, listen: false)
        .add(DeviceEventGetListModel(deviceID: widget.deviceID));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceBloc, DeviceState>(builder: (context, state) {
      if (state.listModel[widget.deviceID] == null) {
        return const CircularProgressIndicator();
      }
      return Column(
          children: state.listModel[widget.deviceID]!
              .map(
                (model) => Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: ExpansionTile(
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    expandedAlignment: Alignment.centerLeft,
                    title: Row(
                      children: [
                        Text(
                          model.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                            child: const Icon(Icons.edit, size: 15),
                            onTap: () async {
                              await editModel(context, model).then((value) {
                                if(value != null){
                                  BlocProvider.of<DeviceBloc>(context,
                                              listen: false)
                                          .add(DeviceEventUpdateModel(
                                              model: value));
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
                        Text(
                          model.count.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Color(0xFF9B9B9B)),
                        ),
                        const Divider(color: Colors.black),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: EquipmentContainer(modelID: model.id),
                      ),
                    ],
                  ),
                ),
              )
              .toList());
    });
  }
}

Future<Model?> editModel(BuildContext context, Model model) async {
  Model? newModel;
  final modelController = TextEditingController();
  modelController.text = model.name;
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
                    if (modelController.text.isNotEmpty) {
                      newModel = Model(
                          name: modelController.text,
                          id: model.id,
                          device_id: model.device_id,
                          count: model.count);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Lưu')),
            ],
          ),
        );
      });
  return newModel;
}

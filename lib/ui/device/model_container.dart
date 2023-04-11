import 'package:divice/business/device.dart';
import 'package:divice/ui/device/modal_bottom_sheet_custom.dart';
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
                              await addOrUpdateModal(
                                context,
                                stringInput: model.name,
                                hintText: 'Input Model name...',
                              ).then((value) {
                                if (value != null) {
                                  BlocProvider.of<DeviceBloc>(context,
                                          listen: false)
                                      .add(
                                    DeviceEventUpdateModel(
                                      modelId: model.id,
                                      modelName: value,
                                    ),
                                  );
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
                          '${model.count} equipment',
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
import 'package:divice/config/color.dart';
import 'widgets/modal_bottom_sheet_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business/device.dart';

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
                                    await addOrUpdateModal(
                                      context,
                                      stringInput: equipment.name,
                                      hintText: 'Input Equipment name...',
                                    ).then((value) {
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
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 56),
                          child: Divider(
                            color: AppColors.blackColor,
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
                    backgroundColor: AppColors.greenColor),
                onPressed: () async {
                  await addOrUpdateModal(context,
                          hintText: 'Input Equipment name...')
                      .then((value) {
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

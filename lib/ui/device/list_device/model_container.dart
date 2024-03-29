import 'package:maintenance/business/device.dart';
import 'package:maintenance/config/color.dart';
import 'package:maintenance/generated/l10n.dart';
import 'widgets/modal_bottom_sheet_custom.dart';
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
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                            child: const Icon(Icons.edit, size: 15),
                            onTap: () async {
                              await addOrUpdateModal(
                                context,
                                stringInput: model.name,
                                hintText: S.of(context).model_hint,
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
                          S.of(context).xx_equipment.replaceFirst(RegExp(r'xx'), model.count.toString()),
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: AppColors.grayColor),
                        ),
                        Divider(color: AppColors.blackColor),
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

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
                          child: Text(
                            equipment.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
                onPressed: () => print('object'),
                child: const Text('Thêm mới')),
          ),
        ],
      );
    });
  }
}

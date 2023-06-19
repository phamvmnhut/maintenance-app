import 'package:maintenance/business/device.dart';
import 'package:maintenance/config/color.dart';
import 'package:maintenance/generated/l10n.dart';
import 'widgets/modal_bottom_sheet_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'device_detail.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({Key? key}) : super(key: key);

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    BlocProvider.of<DeviceBloc>(context, listen: false)
        .add(DeviceEventGetList());
    super.didChangeDependencies();
  }

 

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<DeviceBloc, DeviceState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.only(left: 23, right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 41),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              S.of(context).device,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(height: 21),

                          //Container 1 device
                          ListDeviceDetail(
                            lstDevice: state.list,
                          ),
                          
                          GestureDetector(
                            onTap: () async {
                              await addOrUpdateModal(
                                context,
                                hintText: S.of(context).device_hint,
                              ).then((value) {
                                if (value != null) {
                                  BlocProvider.of<DeviceBloc>(context,
                                          listen: false)
                                      .add(DeviceEventAddDevice(
                                          deviceName: value));
                                  BlocProvider.of<DeviceBloc>(context,
                                          listen: false)
                                      .add(DeviceEventGetList());
                                }
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: AppColors.greenColor,
                              ),
                              child: Text(S.of(context).add_new,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                      color: AppColors.whiteColor)),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

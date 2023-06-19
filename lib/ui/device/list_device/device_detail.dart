import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:maintenance/config/color.dart';
import 'package:maintenance/domain/entities/device.dart';
import 'package:maintenance/generated/l10n.dart';
import '../../../domain/services/admod.dart';
import 'widgets/modal_bottom_sheet_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business/device.dart';
import 'model_container.dart';

class ListDeviceDetail extends StatefulWidget {
  final List<Device> lstDevice;
  const ListDeviceDetail({
    super.key,
    required this.lstDevice,
  });

  @override
  State<ListDeviceDetail> createState() => _ListDeviceDetailState();
}

class _ListDeviceDetailState extends State<ListDeviceDetail> {
  BannerAd? bannerAd;
  @override
  void initState() {
    super.initState();
    _createBannerAd();
  }

  _createBannerAd() {
    bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdModService.bannerAdUnitId!,
      listener: AdModService.bannerAdListener,
      request: const AdRequest(),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.lstDevice
          .asMap()
          .entries
          .map(
            (device) => Column(
              children: [
                bannerAd == null
                    ? Container()
                    : device.key != 2
                        ? Container()
                        : Container(
                            height: 50,
                            margin: const EdgeInsets.all(5),
                            child: AdWidget(ad: bannerAd!),
                          ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: ExpansionTile(
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      expandedAlignment: Alignment.centerLeft,
                      title: Row(
                        children: [
                          Text(
                            device.value.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                              child: const Icon(Icons.edit, size: 15),
                              onTap: () async {
                                await addOrUpdateModal(
                                  context,
                                  stringInput: device.value.name,
                                  hintText: S.of(context).device_hint,
                                ).then((value) {
                                  if (value != null) {
                                    BlocProvider.of<DeviceBloc>(
                                      context,
                                      listen: false,
                                    ).add(
                                      DeviceEventUpdateDevice(
                                        deviceId: device.value.id,
                                        deviceName: value,
                                      ),
                                    );
                                    BlocProvider.of<DeviceBloc>(
                                      context,
                                      listen: false,
                                    ).add(DeviceEventGetList());
                                  }
                                });
                              }),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              S.of(context).xx_model.replaceFirst(
                                  RegExp(r'xx'), device.value.count.toString()),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: AppColors.grayColor)),
                          Divider(color: AppColors.blackColor),
                        ],
                      ),
                      children: [
                        ModelContainer(deviceID: device.value.id),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.greenColor),
                              onPressed: () async {
                                await addOrUpdateModal(
                                  context,
                                  hintText: S.of(context).model_hint,
                                ).then((value) {
                                  if (value != null) {
                                    BlocProvider.of<DeviceBloc>(context,
                                            listen: false)
                                        .add(DeviceEventAddModel(
                                            modelName: value,
                                            deviceId: device.value.id));
                                    BlocProvider.of<DeviceBloc>(context,
                                            listen: false)
                                        .add(DeviceEventGetList());
                                  }
                                });
                              },
                              child: Text(S.of(context).add_new)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),
              ],
            ),
          )
          .toList(),
    );
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maintenance/business/care.dart';
import 'package:maintenance/config/color.dart';
import 'package:maintenance/domain/entities/care.dart';
import 'package:maintenance/domain/entities/equipment.dart';
import 'package:maintenance/generated/l10n.dart';
import 'package:maintenance/ui/care/care_detail.dart';
import 'package:maintenance/ui/notification/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../business/device.dart';
import 'package:intl/intl.dart';
import 'package:maintenance/domain/services/notify.dart';
import 'generate/care_next_date.dart';
import 'widgets/bottom_sheet.dart';
import 'widgets/dropdown_custom.dart';

class AddNewCare extends StatefulWidget {
  const AddNewCare({super.key});

  @override
  State<AddNewCare> createState() => _AddNewCareState();
}

class _AddNewCareState extends State<AddNewCare> {
  String _device = '';
  String _modelID = '';
  String _deviceDetail = '';
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay(
    hour: DateTime.now().hour,
    minute: DateTime.now().minute,
  );
  final memoNameController = TextEditingController();
  final careNextTimeController = TextEditingController();
  final numberDateController = TextEditingController();
  String fileUpload = '';
  Equipment? _equipment;
  String dropDownRoutine = list.first;
  late DateTime nextTime;

  @override
  void didChangeDependencies() {
    BlocProvider.of<DeviceBloc>(context, listen: false)
        .add(DeviceEventGetList());
    super.didChangeDependencies();
  }

  _clearControl() {
    FocusScope.of(context).unfocus();
    _device = '';
    _modelID = '';
    _deviceDetail = '';
    _date = DateTime.now();
    _time = TimeOfDay(
      hour: DateTime.now().hour,
      minute: DateTime.now().minute,
    );
    memoNameController.clear();
    careNextTimeController.clear();
    numberDateController.clear();
    fileUpload = '';
    _equipment = null;
    dropDownRoutine = list.first;
  }

  late NotifyHelper notifyHelper;
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper(context);
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CareBloc, CareState>(
      listener: (context, state) {
        if (state.isCreated && state.careId.isNotEmpty) {
          toastInfo(
            msg: S.of(context).msg_add_care_success,
            backgroundColor: AppColors.greenColor,
          );
          notifyHelper.scheduledNotification('Device Care Notification',
              memoNameController.text, nextTime, state.careId);
          _clearControl();

          Navigator.of(context).push(
            CareDetailPage.route(care_id: state.careId),
          );
          BlocProvider.of<CareBloc>(context, listen: false)
              .add(CareEventAddDataDone());
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: Theme.of(context).canvasColor,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 28, right: 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 52),
                        Container(
                          height: 38,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            S.of(context).add_new_care,
                            style: const TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.only(right: 12.5),
                          height: 38,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                S.of(context).device,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              // Image.asset('assets/images/icon_qr.png',
                              //     width: 14, height: 14),
                              IconButton(
                                  onPressed: (() {
                                    _clearControl();
                                  }),
                                  icon: const Icon(
                                    Icons.playlist_remove,
                                    color: Colors.red,
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        BlocBuilder<DeviceBloc, DeviceState>(
                            builder: (context, state) {
                          return Column(
                            children: [
                              DropdownDeviceCustom(
                                  text: _device,
                                  image: Image.asset('assets/images/drugs.png'),
                                  isDropdown: true,
                                  func: () async {
                                    var value = await showButtomListExpand(
                                        context, state);
                                    if (value.isNotEmpty) {
                                      setState(() {
                                        _device =
                                            '${value.keys.first} | ${value.values.first}';
                                        _modelID = value.keys.last;
                                        _deviceDetail = '';
                                      });
                                    }
                                  }),
                              const SizedBox(height: 8),
                              DropdownDeviceCustom(
                                text: _deviceDetail,
                                image: const Icon(
                                    Icons.format_list_bulleted_sharp,
                                    size: 14),
                                isDropdown: true,
                                func: () async {
                                  if (state.listEquipment.isNotEmpty &&
                                      state.listEquipment[_modelID] != null) {
                                    var equipment =
                                        await showButtomListEquipment(
                                      context,
                                      state.listEquipment[_modelID]!,
                                    );
                                    if (equipment != null) {
                                      setState(() {
                                        _deviceDetail = equipment.name;
                                        _equipment = equipment;
                                      });
                                    }
                                  } else {
                                    toastInfo(
                                        msg: S
                                            .of(context)
                                            .please_choose_device_model);
                                  }
                                },
                              ),
                            ],
                          );
                        }),
                        const SizedBox(height: 10),
                        Container(
                          height: 38,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            S.of(context).memo_name,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                            height: 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Theme.of(context).cardColor),
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              controller: memoNameController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.more_horiz_sharp),
                              ),
                            )),
                        const SizedBox(height: 18),
                        Text(
                          S.of(context).notification,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: Text(
                            S.of(context).start_date,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w300),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: DropdownDeviceCustom(
                                text: DateFormat('dd/MM/yyyy')
                                    .format(_date)
                                    .toString(),
                                image: const Icon(Icons.calendar_month_outlined,
                                    size: 14),
                                isSmall: true,
                                func: () async {
                                  final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate:
                                        DateTime(DateTime.now().year - 2),
                                    lastDate: DateTime(DateTime.now().year + 2),
                                  );
                                  if (picked != null && picked != _date) {
                                    setState(() {
                                      _date = picked;
                                      if (numberDateController
                                          .text.isNotEmpty) {
                                        DateTime careNextDate =
                                            generateCareNextDate(
                                                _date,
                                                dropDownRoutine,
                                                int.parse(
                                                    numberDateController.text));
                                        careNextTimeController.text =
                                            '${DateFormat('dd/MM/yyyy').format(careNextDate)} ${_time.format(context)}';
                                      }
                                    });
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 18),
                            Expanded(
                              flex: 1,
                              child: DropdownDeviceCustom(
                                text: _time.format(context).toString(),
                                image:
                                    const Icon(Icons.more_time_sharp, size: 14),
                                isSmall: true,
                                func: () async {
                                  final TimeOfDay? picker =
                                      await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay(
                                      hour: DateTime.now().hour,
                                      minute: DateTime.now().minute,
                                    ),
                                  );
                                  if (picker != null && picker != _time) {
                                    setState(() {
                                      _time = picker;
                                      if (numberDateController
                                          .text.isNotEmpty) {
                                        DateTime careNextDate =
                                            generateCareNextDate(
                                                _date,
                                                dropDownRoutine,
                                                int.parse(
                                                    numberDateController.text));
                                        careNextTimeController.text =
                                            '${DateFormat('dd/MM/yyyy').format(careNextDate)} ${_time.format(context)}';
                                      }
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 48,
                          width: MediaQuery.of(context).size.width / 2 - 37,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Theme.of(context).cardColor),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: numberDateController,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      DateTime careNextDate =
                                          generateCareNextDate(
                                              _date,
                                              dropDownRoutine,
                                              int.parse(value));
                                      careNextTimeController.text =
                                          '${DateFormat('dd/MM/yyyy').format(careNextDate)} ${_time.format(context)}';
                                    }
                                  },
                                  textAlignVertical: TextAlignVertical.center,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      hintText: '30',
                                      border: InputBorder.none,
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(left: 14.0),
                                        child: Icon(
                                          Icons.wallet_travel_rounded,
                                          size: 14,
                                        ),
                                      )),
                                ),
                              ),
                              DropdownButton(
                                  iconSize: 15,
                                  underline: const SizedBox(),
                                  value: dropDownRoutine,
                                  items: list.map<DropdownMenuItem>((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      dropDownRoutine = value;
                                      if (numberDateController
                                          .text.isNotEmpty) {
                                        DateTime careNextDate =
                                            generateCareNextDate(
                                                _date,
                                                dropDownRoutine,
                                                int.parse(
                                                    numberDateController.text));
                                        careNextTimeController.text =
                                            '${DateFormat('dd/MM/yyyy').format(careNextDate)} ${_time.format(context)}';
                                      }
                                    });
                                  }),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 14.0, top: 7, bottom: 4),
                          child: Text(
                            S.of(context).care_next_time,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                            height: 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Theme.of(context).cardColor),
                            child: TextFormField(
                              readOnly: true,
                              textAlignVertical: TextAlignVertical.center,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                              controller: careNextTimeController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                prefixIcon:
                                    Icon(Icons.share_arrival_time_outlined),
                              ),
                            )),
                        const SizedBox(height: 17),
                        Container(
                          height: 38,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            S.of(context).information,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                ImagePicker imagePicker = ImagePicker();
                                XFile? file = await imagePicker.pickImage(
                                    source: ImageSource.gallery);
                                if (file != null) {
                                  fileUpload = file.path;
                                  setState(() {});
                                }
                              },
                              child:
                                  Image.asset('assets/images/upload_image.png'),
                            ),
                            Expanded(
                                child: fileUpload.isNotEmpty && fileUpload != ''
                                    ? SizedBox(
                                        height: 121,
                                        child: Image.file(File(fileUpload)))
                                    : Container())
                          ],
                        ),
                        const SizedBox(height: 27),
                        GestureDetector(
                          onTap: () {
                            if (_equipment == null) {
                              toastInfo(
                                msg: S.of(context).please_choose_equipment,
                                backgroundColor: AppColors.orangeColor,
                              );
                              return;
                            }
                            if (numberDateController.text.isEmpty) {
                              toastInfo(
                                msg: S.of(context).please_choose_day_week,
                                backgroundColor: AppColors.orangeColor,
                              );
                              return;
                            }
                            DateTime careNextDate = generateCareNextDate(
                              _date,
                              dropDownRoutine,
                              numberDateController.text.isEmpty
                                  ? 0
                                  : int.parse(numberDateController.text),
                            );
                            nextTime = DateTime(
                              careNextDate.year,
                              careNextDate.month,
                              careNextDate.day,
                              _time.hour,
                              _time.minute,
                            );
                            BlocProvider.of<CareBloc>(context, listen: false)
                                .add(
                              CareEventAddData(
                                filePath: fileUpload,
                                care: Care(
                                  id: '',
                                  user_id: '', // add in business
                                  equipment_id: _equipment!.id,
                                  memo_name: memoNameController.text,
                                  image: 'image',
                                  care_next_time: Timestamp.fromDate(nextTime),
                                  routine:
                                      '${numberDateController.text}_${dropDownRoutine.toUpperCase()}',
                                  start_date: Timestamp.fromDate(DateTime(
                                    _date.year,
                                    _date.month,
                                    _date.day,
                                    _time.hour,
                                    _time.minute,
                                  )),
                                  status: 'BAT_DAU',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 56,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: AppColors.greenColor,
                            ),
                            child: Text(S.of(context).done,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    color: AppColors.whiteColor)),
                          ),
                        ),
                        const SizedBox(height: 26),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (state.isCreateProcessing)
              Opacity(
                opacity: 0.6,
                child: ModalBarrier(
                    dismissible: false, color: AppColors.blackColor),
              ),
            if (state.isCreateProcessing)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        );
      },
    );
  }
}

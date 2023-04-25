import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divice/business/care.dart';
import 'package:divice/config/color.dart';
import 'package:divice/domain/entities/care.dart';
import 'package:divice/domain/entities/equipment.dart';
import 'package:divice/ui/care/care_detail.dart';
import 'package:divice/ui/notification/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../business/device.dart';
import 'package:intl/intl.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CareBloc, CareState>(
      listener: (context, state) {
        if (state.isCreated && state.careId.isNotEmpty) {
          toastInfo(
            msg: 'Successfully added new care',
            backgroundColor: AppColors.greenColor,
          );
          _clearControl();
          Navigator.of(context).push(
            CareDetailPage.route(care_id: state.careId),
          );
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
                          child: const Text(
                            'Add new device care',
                            style: TextStyle(
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
                              const Text(
                                'Device',
                                style: TextStyle(
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
                                        msg: 'Please choose Device | Model');
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
                          child: const Text(
                            'Memo name',
                            style: TextStyle(
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
                        const Text(
                          'Notification',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 14.0),
                          child: Text(
                            'Start Date',
                            style: TextStyle(
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
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 14.0, top: 7, bottom: 4),
                          child: Text(
                            'Care next time',
                            style: TextStyle(
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
                          child: const Text(
                            'Information',
                            style: TextStyle(
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
                            if (_equipment == null ||
                                numberDateController.text.isEmpty) {
                              toastInfo(
                                msg: 'Please choose Equipment',
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
                            BlocProvider.of<CareBloc>(context, listen: false)
                                .add(
                              CareEventAddData(
                                filePath: fileUpload,
                                care: Care(
                                  id: 'id',
                                  user_id: 'user_id',
                                  equipment_id: _equipment!.id,
                                  memo_name: memoNameController.text,
                                  image: 'image',
                                  care_next_time: Timestamp.fromDate(DateTime(
                                    careNextDate.year,
                                    careNextDate.month,
                                    careNextDate.day,
                                    _time.hour,
                                    _time.minute,
                                  )),
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
                            child: Text('Done',
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

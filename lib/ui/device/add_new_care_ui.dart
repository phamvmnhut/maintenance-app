import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divice/business/care.dart';
import 'package:divice/business/setting.dart';
import 'package:divice/config/color.dart';
import 'package:divice/config/status.dart';
import 'package:divice/domain/entities/care.dart';
import 'package:divice/domain/entities/equipment.dart';
import 'package:divice/ui/noti/noti_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../business/device.dart';
import 'dropdown_custom.dart';
import 'package:intl/intl.dart';

class AddNewCare extends StatefulWidget {
  const AddNewCare({super.key});

  @override
  State<AddNewCare> createState() => _AddNewCareState();
}

class _AddNewCareState extends State<AddNewCare> {
  String _device = 'Điện thoại | iPhone 14';
  String _modelID = '';
  String _deviceDetail = 'Màn hình';
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
  void initState() {
    super.initState();
    careNextTimeController.text = '2023-04-08 10:00 AM';
  }

  @override
  void didChangeDependencies() {
    BlocProvider.of<DeviceBloc>(context, listen: false)
        .add(DeviceEventGetList());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CareBloc, CareState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Stack(
            children: [
              Scaffold(
                backgroundColor: AppColors.whiteColor,
                body: SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 28, right: 28),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 52),
                        InkWell(
                          onTap: () => BlocProvider.of<ThemeBloc>(context)
                              .add(ChangeScreenEvent(index: 0)),
                          child: Container(
                            alignment: Alignment.center,
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              color: AppColors.grayColor2,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(
                              Icons.arrow_back_sharp,
                              size: 16.0,
                              color: AppColors.grayColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
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
                              Image.asset('assets/images/icon_qr.png',
                                  width: 14, height: 14),
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
                                    var value = await _showButtomListExpand(
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
                                        await _showButtomListEquipment(
                                      context,
                                      state.listEquipment[_modelID]!,
                                    );
                                    if (equipment != null) {
                                      setState(() {
                                        _deviceDetail = equipment.name;
                                        _equipment = equipment;
                                      });
                                    }
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
                                color: AppColors.grayColor2),
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
                              color: AppColors.grayColor2),
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
                                color: AppColors.grayColor2),
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
                                child: fileUpload.isNotEmpty
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
                              NotiBar.showSnackBar(
                                context,
                                'Please choose Equipment',
                                status: NotificationStatusEnum.warning,
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
                            child: Text('Xong',
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
                )),
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
        });
  }
}

Future<Map<String, String>> _showButtomListExpand(
    BuildContext context, DeviceState state) async {
  Map<String, String> result = {};
  await showModalBottomSheet(
      context: context,
      builder: (context) {
        return BlocConsumer<DeviceBloc, DeviceState>(
            listener: (context, state) {},
            builder: (context, state) {
              return state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView(
                      shrinkWrap: true,
                      children: state.list.map((device) {
                        return ExpansionTile(
                          title: Text(device.name),
                          leading: const Icon(Icons.devices_other_sharp),
                          children: state.listModel[device.id]!.map((model) {
                            return ListTile(
                                title: Text(model.name),
                                onTap: () {
                                  result.addAll({device.name: model.name});
                                  result.addAll({model.id: model.name});
                                  Navigator.pop(context);
                                });
                          }).toList(),
                        );
                      }).toList(),
                    );
            });
      });
  return result;
}

Future<Equipment?> _showButtomListEquipment(
    BuildContext context, List<Equipment> list) async {
  Equipment? result;
  await showModalBottomSheet(
      context: context,
      builder: (_) {
        return ListView(
          children: list.map((equipment) {
            return ListTile(
              title: Text(equipment.name),
              onTap: () {
                result = equipment;
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      });
  return result;
}

DateTime generateCareNextDate(DateTime startDate, String typeDate, int number) {
  DateTime newDate;
  switch (typeDate.toString().toUpperCase()) {
    case 'DAYS':
      newDate = DateTime(
        startDate.year,
        startDate.month,
        startDate.day + number,
      );
      break;
    case 'WEEKS':
      newDate = DateTime(
        startDate.year,
        startDate.month,
        startDate.day + 7 * number,
      );
      break;
    case 'MONTHS':
      newDate = DateTime(
        startDate.year,
        startDate.month + number,
        startDate.day,
      );
      break;
    case 'YEARS':
      newDate = DateTime(
        startDate.year + number,
        startDate.month,
        startDate.day,
      );
      break;
    default:
      newDate = DateTime.now();
  }
  return newDate;
}

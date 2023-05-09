// ignore_for_file: non_constant_identifier_names

import 'package:divice/business/care.dart';
import 'package:divice/business/care_detail.dart';
import 'package:divice/config/color.dart';
import 'package:divice/domain/repositories/firebase/care_history_repository_firebase.dart';
import 'package:divice/domain/repositories/firebase/care_repository_firebase.dart';
import 'package:divice/ui/care/widgets/care_edit_bottomsheet.dart';
import 'package:divice/ui/care/widgets/care_history_add_bottomsheet.dart';
import 'package:divice/ui/care/widgets/care_history_edit_or_delete_bottomsheet.dart';
import 'package:divice/ui/care/widgets/care_status_toggle.dart';
import 'package:divice/ui/care/widgets/equipment_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:divice/generated/l10n.dart';
import 'package:intl/intl.dart';

import '../components/app_alert.dart';

class CareDetailPage extends StatelessWidget {
  const CareDetailPage({Key? key}) : super(key: key);

  static Route<void> route({required String care_id}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => CareDetailBloc(
          careRepository: context.read<CareRepositoryFireBase>(),
          careHistoryRepository: context.read<CareHistoryRepositoryFireBase>(),
          careId: care_id,
        ),
        child: const CareDetailPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CareDetailBloc, CareDetailState>(
      listenWhen: (previous, current) => previous.careId != current.careId,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const CareDetailView(),
    );
  }
}

class CareDetailView extends StatefulWidget {
  const CareDetailView({Key? key}) : super(key: key);

  @override
  State<CareDetailView> createState() => _CareDetailViewState();
}

class _CareDetailViewState extends State<CareDetailView> {
  @override
  void didChangeDependencies() {
    context.read<CareDetailBloc>().add(CareDetailEventGetAllData());
    super.didChangeDependencies();
  }

  final DateTime _nowTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: BlocBuilder<CareDetailBloc, CareDetailState>(
        builder: (context, state) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 52),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          Icons.arrow_back_sharp,
                          size: 16.0,
                          color: AppColors.grayColor,
                        ),
                      ),
                    ),
                  ),
                  if (state.care?.status != null)
                    CareStatusToggle(status: state.care!.status),
                ],
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      state.care?.memo_name ?? "",
                      softWrap: true,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ),
              const SizedBox(height: 12),
              EquipmentData(equipmentId: state.care?.equipment_id),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset('assets/images/time.png'),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      S.of(context).next_time_care,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    if (state.care?.care_next_time != null)
                                      Text(
                                        DateFormat.yMd('es').format(state
                                            .care!.care_next_time
                                            .toDate()),
                                      ),
                                    if (state.care?.care_next_time != null)
                                      Text(
                                        DateFormat.jms().format(state
                                            .care!.care_next_time
                                            .toDate()),
                                      ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(S.of(context).reminder,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                      )),
                                  if (state.care?.care_next_time != null)
                                    Text(
                                      "${state.care!.getNumberInRoutine()} ${state.care!.getTypeInRoutine()}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset('assets/images/heart.png'),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      S.of(context).time_used,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    if (state.care?.start_date != null)
                                      Text(
                                        S.of(context).xx_day.replaceFirst(
                                              RegExp(r'xx'),
                                              _nowTime
                                                  .difference(state
                                                      .care!.start_date
                                                      .toDate())
                                                  .inDays
                                                  .toString(),
                                            ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).care_time,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(S.of(context).have_care_time.replaceFirst(
                            RegExp(r'xx'),
                            state.careHistorylist.length.toString())),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        careHistoryAddBottomSheet(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          Icons.add,
                          size: 16.0,
                          color: AppColors.grayColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Stack(
                children: [
                  Container(
                    width: 70,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withAlpha(70),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: state.isLoading
                          ? const CircularProgressIndicator()
                          : Column(
                              children: state.careHistorylist
                                  .map(
                                    (e) => Container(
                                      margin: const EdgeInsets.only(top: 12),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Theme.of(context).cardColor,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 28, right: 16),
                                            child: Image.asset(
                                                'assets/images/drugs.png'),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  e.memo,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(DateFormat()
                                                    .format(e.date)
                                                    .toString())
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    careHistoryEditOrDeleteBottomSheet(
                                                        context, e);
                                                  },
                                                  child: const Icon(
                                                      Icons.edit_note),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ))
                ],
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          careEditBottomSheet(context, state.care!);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Text(
                            S.of(context).edit,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          alertDialogDeleteApp(context).then((value) {
                            if (value == true) {
                              BlocProvider.of<CareBloc>(
                                context,
                                listen: false,
                              ).add(CareEventDelete(careId: state.careId));
                              Navigator.pop(context);
                            }
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Theme.of(context).errorColor,
                          ),
                          child: Text(
                            S.of(context).delete,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

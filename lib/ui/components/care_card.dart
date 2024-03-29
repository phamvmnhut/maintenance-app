import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maintenance/config/color.dart';
import 'package:maintenance/domain/entities/care.dart';
import 'package:maintenance/domain/repositories/firebase/equipment_repository_firebase.dart';

import '../care/care_detail.dart';

class CareCard extends StatefulWidget {
  const CareCard({Key? key, required this.e}) : super(key: key);
  final Care e;

  @override
  State<CareCard> createState() => _CareCardState();
}

class _CareCardState extends State<CareCard> {
  Image imageDrugs = Image.asset('assets/images/drugs.png');

  Future<String> getData(String id) {
    return RepositoryProvider.of<EquipmentRepositoryFirebase>(context)
        .get(id: id)
        .then((value) => value.name);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CareDetailPage.route(care_id: widget.e.id),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          top: 12,
          right: 28,
          left: 28,
        ),
        height: 72,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Theme.of(context).cardColor,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10), // Image border
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(16), // Image radius
                  child: widget.e.image != ''
                      ? Image.network(widget.e.image, fit: BoxFit.cover)
                      : imageDrugs,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 3),
                    child: Text(
                      widget.e.memo_name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      children: [
                        _Timer(
                          timeAfter: widget.e.care_next_time.toDate(),
                          careNextTime: widget.e.care_next_time.toDate(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 5,
                            right: 5,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.yellowColor,
                                borderRadius: BorderRadius.circular(5)),
                            height: 4,
                            width: 4,
                          ),
                        ),
                        FutureBuilder(
                            future: getData(widget.e.equipment_id),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.hasData) {
                                return Expanded(
                                  child: Text(
                                    snapshot.data!,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: AppColors.yellowColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
                                  ),
                                );
                              }
                              return const Text('');
                            })
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Icon(Icons.keyboard_arrow_right),
            const SizedBox(width: 14)
          ],
        ),
      ),
    );
  }
}

class _Timer extends StatefulWidget {
  const _Timer({Key? key, required this.timeAfter, required this.careNextTime})
      : super(key: key);
  final DateTime timeAfter;
  final DateTime careNextTime;
  @override
  State<_Timer> createState() => _TimerState();
}

class _TimerState extends State<_Timer> {
  DateTime _nowTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _nowTime = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      timeFormat(),
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: AppColors.yellowColor,
          fontWeight: FontWeight.w500,
          fontSize: 13),
    );
  }

  String timeFormat() {
    Duration timeAfter = widget.timeAfter.difference(_nowTime);
    int timeAfterHours = timeAfter.inHours;

    Duration timeBefore = _nowTime.difference(widget.careNextTime);
    int timeBeforeHours = timeBefore.inHours;

    return timeAfterHours > 0
        ? timeAfterHours > 24
            ? 'After ${timeAfter.inDays} ${timeAfter.inDays > 1 ? 'days' : 'day'}'
            : timeAfterHours < 24 && timeAfterHours > 0
                ? 'After ${timeAfterHours}h${timeAfter.inMinutes % 60}m'
                : ''
        : timeBeforeHours > 24
            ? '${timeBefore.inDays} ${timeBefore.inDays > 1 ? 'days ago' : 'day ago'}'
            : timeBeforeHours < 24 && timeBeforeHours > 0
                ? '${timeBeforeHours}h${timeBefore.inMinutes % 60}m ago'
                : '';
  }
}

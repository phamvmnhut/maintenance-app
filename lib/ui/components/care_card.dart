import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:divice/config/color.dart';
import 'package:divice/domain/entities/care.dart';
import 'package:divice/domain/repositories/firebase/equipment_repository_firebase.dart';

import '../care/care_detail.dart';

class CareCard extends StatefulWidget {
  const CareCard({Key? key, required this.e}) : super(key: key);
  final Care e;

  @override
  State<CareCard> createState() => _CareCardState();
}

class _CareCardState extends State<CareCard> {
  final DateTime _nowTime = DateTime.now();

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
              padding: const EdgeInsets.only(left: 28),
              child: Image.asset('assets/images/drugs.png'),
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
                        Text(
                          widget.e.start_date
                                      .toDate()
                                      .difference(_nowTime)
                                      .inHours >
                                  24
                              ? 'after ${widget.e.start_date.toDate().difference(_nowTime).inDays} days'
                              : 'after ${widget.e.start_date.toDate().difference(_nowTime).inHours}h${widget.e.start_date.toDate().difference(_nowTime).inMinutes}m',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: AppColors.yellowColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 13),
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
                                return Text(
                                  snapshot.data!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: AppColors.yellowColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
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

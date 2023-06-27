import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:maintenance/business/notify.dart';
import 'package:maintenance/domain/entities/notification.dart';
import 'package:maintenance/ui/care/care_detail.dart';

Widget notificationItem(
    BuildContext context, NotificationModel notificationModel) {
  return GestureDetector(
    onTap: () {
      context
          .read<NotifyBloc>()
          .add(NotifyEventUpdate(id: notificationModel.id!));
      Navigator.of(context).push(
        CareDetailPage.route(care_id: notificationModel.careId!),
      );
    },
    child: Container(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  SizedBox(
                    height: 36,
                    width: 36,
                    child: Image.asset('assets/images/bell.png'),
                  ),
                  notificationModel.seen == 0
                      ? Container(
                          height: 14,
                          width: 14,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(7),
                          ),
                        )
                      : Container(),
                ],
              ),
              const SizedBox(width: 30),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notificationModel.memoName!,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: notificationModel.seen == 0
                          ? FontWeight.w600
                          : FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    DateFormat('dd/MM/yyyy HH:mm:ss')
                        .format(DateTime.fromMillisecondsSinceEpoch(
                            notificationModel.dateTime! * 1000))
                        .toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: notificationModel.seen == 0
                          ? FontWeight.w600
                          : FontWeight.w300,
                    ),
                  ),
                ],
              ))
            ],
          ),
          const SizedBox(height: 10),
          const Divider()
        ],
      ),
    ),
  );
}

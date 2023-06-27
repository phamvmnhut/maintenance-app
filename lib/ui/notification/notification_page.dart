import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintenance/business/notify.dart';
import 'package:maintenance/domain/entities/notification.dart';
import 'package:maintenance/generated/l10n.dart';
import 'package:maintenance/ui/notification/widgets/notification_widget.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void didChangeDependencies() {
    BlocProvider.of<NotifyBloc>(context, listen: false)
        .add(NotifyEventGetList());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        foregroundColor: Theme.of(context).hintColor,
        title: Text(S.current.notification),
        centerTitle: true,
        elevation: 0.3,
        actions: [
          IconButton(
            onPressed: () {
              context.read<NotifyBloc>().add(
                    NotifyEventAdd(
                      model: NotificationModel(
                          careId: 'CareId',
                          dateTime: DateTime.now().toString(),
                          memoName: 'MemoName ${DateTime.now().second}',
                          seen: 0),
                    ),
                  );
            },
            icon: const Icon(Icons.add_alert_rounded),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: BlocBuilder<NotifyBloc, NotifyState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: state.list.map((notify) {
                return notificationItem(
                  context,
                  notify,
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}

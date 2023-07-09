import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintenance/domain/entities/notification.dart';
import 'package:maintenance/domain/repositories/notify_repository.dart';

abstract class NotifyEvent {}

class NotifyEventGetList extends NotifyEvent {}

class NotifyEventUpdate extends NotifyEvent {
  final int id;
  NotifyEventUpdate({required this.id});
}

class NotifyEventAdd extends NotifyEvent {
  final NotificationModel model;
  NotifyEventAdd({required this.model});
}

class NotifyEventCheckNotSeen extends NotifyEvent {
  NotifyEventCheckNotSeen();
}

class NotifyState {
  List<NotificationModel> list;
  bool isLoading;
  bool notSeen;
  NotifyState({
    this.list = const [],
    this.isLoading = false,
    this.notSeen = false,
  });

  NotifyState.initialState() : this(list: []);

  NotifyState copyWith({
    List<NotificationModel>? list,
    bool? isLoading,
    bool? notSeen,
  }) {
    return NotifyState(
        list: list ?? this.list,
        isLoading: isLoading ?? this.isLoading,
        notSeen: notSeen ?? this.notSeen);
  }
}

class NotifyBloc extends Bloc<NotifyEvent, NotifyState> {
  final NotifyRepository _repository;
  NotifyBloc(this._repository) : super(NotifyState.initialState()) {
    on<NotifyEventGetList>(_getAll);
    on<NotifyEventAdd>(_insert);
    on<NotifyEventUpdate>(_update);
    on<NotifyEventCheckNotSeen>(_seen);
  }

  FutureOr<void> _getAll(
      NotifyEventGetList event, Emitter<NotifyState> emit) async {
    emit(state.copyWith(isLoading: true));
    List<NotificationModel> list = await _repository.getAll();
    emit(state.copyWith(
      list: list,
      isLoading: false,
    ));
  }

  FutureOr<void> _insert(
      NotifyEventAdd event, Emitter<NotifyState> emit) async {
    emit(state.copyWith(isLoading: true));
    await _repository.insertNotify(event.model);
    List<NotificationModel> list = await _repository.getAll();
    emit(state.copyWith(
      list: list,
      isLoading: false,
    ));
  }

  FutureOr<void> _update(
      NotifyEventUpdate event, Emitter<NotifyState> emit) async {
    emit(state.copyWith(isLoading: true));
    await _repository.updateSeen(event.id);
    List<NotificationModel> list = await _repository.getAll();
    emit(state.copyWith(
      list: list,
      isLoading: false,
    ));
  }

  FutureOr<void> _seen(
      NotifyEventCheckNotSeen event, Emitter<NotifyState> emit) async {
    var count = await _repository.getHaveNotify();
    emit(state.copyWith(notSeen: (count != null && count > 0)));
  }
}

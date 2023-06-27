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

class NotifyState {
  List<NotificationModel> list;
  bool isLoading;
  NotifyState({
    this.list = const [],
    this.isLoading = false,
  });

  NotifyState.initialState() : this(list: []);

  NotifyState copyWith({
    List<NotificationModel>? list,
    bool? isLoading,
  }) {
    return NotifyState(
        list: list ?? this.list, isLoading: isLoading ?? this.isLoading);
  }
}

class NotifyBloc extends Bloc<NotifyEvent, NotifyState> {
  final NotifyRepository _repository;
  NotifyBloc(this._repository) : super(NotifyState.initialState()) {
    on<NotifyEventGetList>(_getAll);
    on<NotifyEventAdd>(_insert);
    on<NotifyEventUpdate>(_update);
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
}

import 'package:divice/domain/entities/care_history.dart';
import 'package:divice/domain/entities/care.dart';
import 'package:divice/domain/repositories/care_history_repository.dart';
import 'package:divice/domain/repositories/care_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CareDetailEvent {}

class CareDetailEventGetAllData extends CareDetailEvent {}

class CareDetailEventGetCareHistoryList extends CareDetailEvent {}

class CareDetailEventUpdateCare extends CareDetailEvent {
  final String? equipment_id;
  final String? memo_name;
  final String? image;
  final String? routine;
  final DateTime? start_date;
  final String? status;

  CareDetailEventUpdateCare({
    this.equipment_id,
    this.memo_name,
    this.image,
    this.routine,
    this.start_date,
    this.status,
  });
}

class CareDetailEventCreateHistory extends CareDetailEvent {
  final CareHistory newHistory;
  CareDetailEventCreateHistory({required this.newHistory});
}

class CareDetailEventUpdateHistory extends CareDetailEvent {
  final CareHistory history;
  CareDetailEventUpdateHistory({required this.history});
}

class CareDetailEventDeleteHistory extends CareDetailEvent {
  final CareHistory history;
  CareDetailEventDeleteHistory({required this.history});
}

class CareDetailState {
  bool isLoading = true;
  Care? care;
  List<CareHistory> careHistorylist;
  String careId;

  CareDetailState(
      {this.careHistorylist = const [],
      this.careId = "",
      this.isLoading = true,
      this.care});
  CareDetailState.initialState() : this();

  CareDetailState copyWith({
    bool? isLoading,
    List<CareHistory>? careHistorylist,
    String? careId,
    Care? care,
  }) {
    return CareDetailState(
      isLoading: isLoading ?? this.isLoading,
      careHistorylist: careHistorylist ?? this.careHistorylist,
      careId: careId ?? this.careId,
      care: care ?? this.care,
    );
  }
}

class CareDetailBloc extends Bloc<CareDetailEvent, CareDetailState> {
  final CareHistoryRepository _careHistoryRepository;
  final CareRepository _careRepository;

  CareDetailBloc({
    required CareRepository careRepository,
    required CareHistoryRepository careHistoryRepository,
    required String careId,
  })  : _careHistoryRepository = careHistoryRepository,
        _careRepository = careRepository,
        super(CareDetailState(
          careId: careId,
        )) {
    on<CareDetailEventGetCareHistoryList>(_getList);
    on<CareDetailEventGetAllData>(_getAllData);
    on<CareDetailEventUpdateCare>(_updateCare);
    on<CareDetailEventCreateHistory>(_addNewHistory);
    on<CareDetailEventUpdateHistory>(_updateHistory);
    on<CareDetailEventDeleteHistory>(_deleteHistory);
  }
  void _getList(CareDetailEventGetCareHistoryList event,
      Emitter<CareDetailState> emit) async {
    List<CareHistory> l = await _careHistoryRepository.getList(
        param: CareHistoryRepositoryGetListParam(care_id: ""));
    emit(CareDetailState(careHistorylist: l));
  }

  void _getAllData(
      CareDetailEventGetAllData event, Emitter<CareDetailState> emit) async {
    emit(state.copyWith(isLoading: true));
    List<CareHistory> l = await _careHistoryRepository.getList(
        param: CareHistoryRepositoryGetListParam(care_id: state.careId));
    Care? c = await _careRepository.get(id: state.careId);
    emit(state.copyWith(careHistorylist: l, isLoading: false, care: c));
  }

  void _updateCare(
      CareDetailEventUpdateCare event, Emitter<CareDetailState> emit) async {
    if (state.care == null) return;
    emit(state.copyWith(isLoading: true));
    Care oldCare = state.care!;
    Care updateCareData = oldCare.copyWith(
      memo_name: event.memo_name ?? oldCare.memo_name,
      status: event.status ?? oldCare.status,
    );

    await _careRepository.update(id: oldCare.id, data: updateCareData);
    Care? updatedCare = await _careRepository.get(id: oldCare.id);
    emit(state.copyWith(isLoading: false, care: updatedCare));
  }

  void _addNewHistory(
      CareDetailEventCreateHistory event, Emitter<CareDetailState> emit) async {
    emit(state.copyWith(isLoading: true));
    CareHistory newHistory = event.newHistory.copyWith(
      id: "",
      care_id: state.careId,
      date: DateTime.now(),
      image:
          "https://firebasestorage.googleapis.com/v0/b/divice-829e1.appspot.com/o/images%2F1682393683722?alt=media&token=0b82c776-e32f-49ae-970f-7a220b818be5",
    );
    await _careHistoryRepository.create(d: newHistory);
    List<CareHistory> l = await _careHistoryRepository.getList(
        param: CareHistoryRepositoryGetListParam(care_id: state.careId));
    emit(state.copyWith(careHistorylist: l, isLoading: false));
  }

  void _updateHistory(
      CareDetailEventUpdateHistory event, Emitter<CareDetailState> emit) async {
    emit(state.copyWith(isLoading: true));
    await _careHistoryRepository.update(
        data: event.history, id: event.history.id);
    List<CareHistory> l = await _careHistoryRepository.getList(
        param: CareHistoryRepositoryGetListParam(care_id: state.careId));
    emit(state.copyWith(careHistorylist: l, isLoading: false));
  }

  void _deleteHistory(
      CareDetailEventDeleteHistory event, Emitter<CareDetailState> emit) async {
    emit(state.copyWith(isLoading: true));
    await _careHistoryRepository.delete(id: event.history.id);
    List<CareHistory> l = await _careHistoryRepository.getList(
        param: CareHistoryRepositoryGetListParam(care_id: state.careId));
    emit(state.copyWith(careHistorylist: l, isLoading: false));
  }
}

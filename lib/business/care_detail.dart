import 'package:divice/domain/entities/care_history.dart';
import 'package:divice/domain/entities/care.dart';
import 'package:divice/domain/repositories/care_history_repository.dart';
import 'package:divice/domain/repositories/care_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CareDetailEvent {}

class CareDetailEventGetAllData extends CareDetailEvent {}

class CareDetailEventGetCareHistoryList extends CareDetailEvent {}

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
  })  : _careHistoryRepository = careHistoryRepository, _careRepository = careRepository,
      super(CareDetailState(
          careId: careId,
        )) {
    on<CareDetailEventGetCareHistoryList>(_getList);
    on<CareDetailEventGetAllData>(_getAllData);
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
    Care c = await _careRepository.get(id: state.careId);
    emit(state.copyWith(careHistorylist: l, isLoading: false, care: c));
  }
}

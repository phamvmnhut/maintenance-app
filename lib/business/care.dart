import 'package:divice/domain/repositories/care_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:divice/domain/entities/care.dart';

abstract class CareEvent {}

class CareEventGetAllData extends CareEvent {}

class CareEventGetCareList extends CareEvent {}

class CareState {
  bool isLoading = true;
  Care? care;
  List<Care> careList;
  String careId;

  CareState(
      {this.careList = const [],
      this.careId = '',
      this.isLoading = true,
      this.care});
  CareState.initialState() : this();

  CareState copyWith({
    bool? isLoading,
    List<Care>? careList,
    String? careId,
    Care? care,
  }) {
    return CareState(
      isLoading: isLoading ?? this.isLoading,
      careList: careList ?? this.careList,
      careId: careId ?? this.careId,
      care: care ?? this.care,
    );
  }
}

class CareBloc extends Bloc<CareEvent, CareState> {
  final CareRepository _repository;

  CareBloc(
    CareRepository of, {
    required CareRepository careRepository,
    required String careId,
  })  : _repository = careRepository,
        super(CareState(
          careId: careId,
        )) {
    on<CareEventGetCareList>(_getList);
    on<CareEventGetAllData>(_getAllData);
  }
  void _getList(CareEventGetCareList event, Emitter<CareState> emit) async {
    List<Care> l = (await _repository.getList(
        param: CareRepositoryGetListParam(careId: "")));
    emit(CareState(careList: l));
  }

  void _getAllData(CareEventGetAllData event, Emitter<CareState> emit) async {
    emit(state.copyWith(isLoading: true));
    List<Care> l = await _repository.getList(
        param: CareRepositoryGetListParam(careId: state.careId));
    emit(state.copyWith(careList: l, isLoading: false));
  }
}

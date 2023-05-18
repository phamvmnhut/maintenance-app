import 'dart:io';

import 'package:maintenance/domain/repositories/care_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintenance/domain/entities/care.dart';

abstract class CareEvent {}

class CareEventSearch extends CareEvent {
  final String name;
  CareEventSearch({required this.name});
}

class CareEventSetup extends CareEvent {}

class CareEventAddData extends CareEvent {
  final String filePath;
  final Care care;
  CareEventAddData({
    required this.filePath,
    required this.care,
  });
}

class CareEventAddDataDone extends CareEvent {}

class CareEventDelete extends CareEvent {
  final String careId;
  CareEventDelete({required this.careId});
}

class CareState {
  bool isLoading = true;
  Care? care;
  List<Care> careList;
  List<Care> careSoonList;
  String careId;
  bool isCreateProcessing = false;
  bool isCreated = false;

  CareState({
    this.careList = const [],
    this.careSoonList = const [],
    this.careId = '',
    this.isLoading = true,
    this.care,
    this.isCreateProcessing = false,
    this.isCreated = false,
  });
  CareState.initialState() : this();

  CareState copyWith({
    bool? isLoading,
    List<Care>? careList,
    List<Care>? careSoonList,
    String? careId,
    Care? care,
    bool? isCreateProcessing,
    bool? isCreated,
  }) {
    return CareState(
      isLoading: isLoading ?? this.isLoading,
      careList: careList ?? this.careList,
      careSoonList: careSoonList ?? this.careSoonList,
      careId: careId ?? this.careId,
      care: care ?? this.care,
      isCreateProcessing: isCreateProcessing ?? this.isCreateProcessing,
      isCreated: isCreated ?? this.isCreated,
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
    on<CareEventSetup>(_getSetupData);
    on<CareEventSearch>(_search);
    on<CareEventAddData>(_addData);
    on<CareEventAddDataDone>(_addDataDone);
    on<CareEventDelete>(_deleteOne);
  }
  void _getSetupData(CareEventSetup event, Emitter<CareState> emit) async {
    List<Care> listSoon = await _repository.getList(
      param: CareRepositoryGetListParam(name: "", isSortByCareNextTime: true),
      userId: FirebaseAuth.instance.currentUser?.uid,
    );
    List<Care> list = await _repository.search(
      param: CareRepositorySearchParam(name: ""),
      userId: FirebaseAuth.instance.currentUser?.uid,
    );
    emit(CareState(careSoonList: listSoon, careList: list, isLoading: false));
  }

  void _search(CareEventSearch event, Emitter<CareState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      List<Care> l = await _repository.search(
        param: CareRepositorySearchParam(name: event.name),
        userId: FirebaseAuth.instance.currentUser!.uid,
      );
      emit(state.copyWith(careList: l, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _addData(CareEventAddData event, Emitter<CareState> emit) async {
    emit(state.copyWith(
      isCreateProcessing: true,
      isCreated: false,
    ));
    String imageUrl = '';
    if (event.filePath != '' || event.filePath.isNotEmpty) {
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference root = FirebaseStorage.instance.ref();
      Reference dirImages = root.child('images');
      Reference fileUpload = dirImages.child(uniqueFileName);
      await fileUpload.putFile(File(event.filePath));
      imageUrl = await fileUpload.getDownloadURL();
    }
    Care newCare = Care(
      id: '',
      user_id: FirebaseAuth.instance.currentUser!.uid,
      equipment_id: event.care.equipment_id,
      memo_name: event.care.memo_name,
      image: imageUrl,
      care_next_time: event.care.care_next_time,
      routine: event.care.routine,
      start_date: event.care.start_date,
      status: CareStatus.Active(),
    );

    String careId = await _repository.create(d: newCare);
    emit(state.copyWith(
        isCreateProcessing: false, isCreated: true, careId: careId));
  }

  void _addDataDone(CareEventAddDataDone event, Emitter<CareState> emit) async {
    emit(state.copyWith(isCreated: false));
  }

  void _deleteOne(CareEventDelete event, Emitter<CareState> emit) async {
    bool result = await _repository.delete(id: event.careId);
    if (result == true) {
      List<Care> listSoon = await _repository.getList(
          param:
              CareRepositoryGetListParam(name: "", isSortByCareNextTime: true),
          userId: FirebaseAuth.instance.currentUser?.uid);
      List<Care> list = await _repository.search(
        param: CareRepositorySearchParam(name: ""),
        userId: FirebaseAuth.instance.currentUser?.uid,
      );
      emit(CareState(careSoonList: listSoon, careList: list, isLoading: false));
    }
  }
}

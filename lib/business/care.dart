import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divice/domain/repositories/care_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:divice/domain/entities/care.dart';

abstract class CareEvent {}

class CareEventGetAllData extends CareEvent {}

class CareEventGetCareList extends CareEvent {}

class CareEventAddData extends CareEvent {
  final String filePath;
  final Care care;
  CareEventAddData({required this.filePath, required this.care});
}

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
    on<CareEventAddData>(_addData);
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

  void _addData(CareEventAddData event, Emitter<CareState> emit) async {
    emit(state.copyWith(isLoading: true));
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference root = FirebaseStorage.instance.ref();
    Reference dirImages = root.child('images');
    Reference fileUpload = dirImages.child(uniqueFileName);
    await fileUpload.putFile(File(event.filePath));
    String imageUrl = await fileUpload.getDownloadURL();

    Care newCare = Care(
        id: '',
        user_id: 'AD',
        equipment_id: event.care.equipment_id,
        memo_name: event.care.memo_name,
        image: imageUrl,
        care_next_time: event.care.care_next_time,
        routine: event.care.routine,
        start_date: event.care.start_date,
        status: event.care.status);

    await _repository.create(d: newCare);
    emit(state.copyWith(care: event.care, isLoading: false));
  }
}

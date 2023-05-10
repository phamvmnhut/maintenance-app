import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../domain/services/upload_image.dart';

abstract class AuthEvent {}

class AuthEventSetup extends AuthEvent {}

class AuthEventLogin extends AuthEvent {
  final User user;
  AuthEventLogin({required this.user});
}

class AuthEventLogout extends AuthEvent {}

class AuthEventSentEmailVerify extends AuthEvent {}

class AuthEventUpdateUser extends AuthEvent {
  final String? newName;
  final String? imagePath;
  AuthEventUpdateUser({this.imagePath, this.newName});
}

class AuthState {
  bool isAuth;
  User? user;

  AuthState({required this.isAuth, this.user});
  AuthState.initialState() : this(isAuth: false);

  String get userName {
    if (!isAuth) return "No login";
    if (user!.displayName == null || user!.displayName!.isEmpty == true) {
      return "No Name";
    } else {
      return user!.displayName!;
    }
  }

  AuthState copyWith({
    bool? isAuth,
    User? user,
  }) {
    return AuthState(
      isAuth: isAuth ?? this.isAuth,
      user: user ?? this.user,
    );
  }
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initialState()) {
    on<AuthEventSetup>(_setupStartApp);
    on<AuthEventLogin>(_loginUser);
    on<AuthEventLogout>(_logoutUser);
    on<AuthEventSentEmailVerify>(_sentVerifyEmail);
    on<AuthEventUpdateUser>(_updateUser);
  }

  void _loginUser(AuthEventLogin event, Emitter<AuthState> emit) {
    emit(AuthState(isAuth: true, user: event.user));
  }

  void _logoutUser(AuthEventLogout event, Emitter<AuthState> emit) async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    emit(state.copyWith(isAuth: false, user: null));
  }

  void _setupStartApp(AuthEventSetup event, Emitter<AuthState> emit) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(state.copyWith(isAuth: false, user: null));
    } else {
      emit(state.copyWith(isAuth: true, user: user));
    }
  }

  void _sentVerifyEmail(
      AuthEventSentEmailVerify event, Emitter<AuthState> emit) {
    if (state.user == null) return;
    state.user?.sendEmailVerification();
  }

  void _updateUser(AuthEventUpdateUser event, Emitter<AuthState> emit) async {
    if (state.user == null) return;
    if (event.newName != null) {
      await state.user?.updateDisplayName(event.newName!);
    }
    if (event.imagePath != null) {
      String imageUrlUploaded = await UploadImage.byFireBase(event.imagePath!);
      await state.user?.updatePhotoURL(imageUrlUploaded);
    }
    User? user = FirebaseAuth.instance.currentUser;
    emit(state.copyWith(user: user));
  }
}

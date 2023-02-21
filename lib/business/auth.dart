import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AuthEvent {}

class LoginAuthEvent extends AuthEvent {
  final User user;
  LoginAuthEvent({required this.user});
}

class LogoutAuthEvent extends AuthEvent {}

class AuthState {
  bool isAuth;
  User? user;

  AuthState({required this.isAuth, this.user});
  AuthState.initialState()
      : this(isAuth: false);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initialState()) {
    on<LoginAuthEvent>((event, emit) {
      emit(AuthState(isAuth: true, user: event.user));
    });
    on<LogoutAuthEvent>((event, emit) {
      emit(AuthState(isAuth: false));
    });
  }
}

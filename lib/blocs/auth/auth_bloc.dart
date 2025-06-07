import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState(AuthStatus.unauthenticated)) {
    on<AuthLoginRequested>((event, emit) async {
      emit(const AuthState(AuthStatus.authenticated));

      await Future.delayed(const Duration(seconds: 2));

      add(AuthLogoutRequested());
    });

    on<AuthLogoutRequested>((event, emit) {
      emit(const AuthState(AuthStatus.unauthenticated));
      print('Logout');
    });
  }
}

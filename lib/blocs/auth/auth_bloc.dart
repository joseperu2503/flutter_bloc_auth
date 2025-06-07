import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState.unauthenticated()) {
    on<AuthLoginRequested>((event, emit) async {
      const fakeToken = '1234567890abcdef';

      // Guardamos el token al autenticar
      emit(const AuthState.authenticated(fakeToken));
      print('Token guardado: $fakeToken');

      // await Future.delayed(const Duration(seconds: 2));

      // add(AuthLogoutRequested());
    });

    on<AuthLogoutRequested>((event, emit) {
      // Eliminamos el token al cerrar sesión
      emit(const AuthState.unauthenticated());
      print('Token eliminado. Logout');
    });
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static const _tokenKey = 'auth_token';

  AuthBloc() : super(const AuthState.unauthenticated()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthCheckStatus>(_onCheckStatus);
  }

  Future<void> _onLoginRequested(
      AuthLoginRequested event, Emitter<AuthState> emit) async {
    const fakeToken = '1234567890abcdef';

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, fakeToken);

    emit(const AuthState.authenticated(fakeToken));
    print('Token guardado: $fakeToken');
  }

  Future<void> _onLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);

    emit(const AuthState.unauthenticated());
    print('Token eliminado. Logout');
  }

  Future<void> _onCheckStatus(
      AuthCheckStatus event, Emitter<AuthState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);

    if (token != null) {
      emit(AuthState.authenticated(token));
      print('Sesión activa con token: $token');
    } else {
      emit(const AuthState.unauthenticated());
      print('No hay token guardado');
    }
  }
}

abstract class AuthEvent {}

class AuthLoginRequested extends AuthEvent {}

class AuthLogoutRequested extends AuthEvent {}

class AuthCheckStatus extends AuthEvent {}

enum AuthStatus { authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  final String? token;

  const AuthState(this.status, {this.token});

  const AuthState.authenticated(String token)
      : this(AuthStatus.authenticated, token: token);

  const AuthState.unauthenticated()
      : this(AuthStatus.unauthenticated, token: null);

  @override
  String toString() => 'AuthState(status: $status, token: $token)';
}

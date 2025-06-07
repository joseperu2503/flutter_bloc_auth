import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_auth/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc_auth/blocs/auth/auth_state.dart';
import 'package:flutter_bloc_auth/screens/home_screen.dart';
import 'package:flutter_bloc_auth/screens/login_screen.dart';
import 'package:go_router/go_router.dart';

late final GoRouter router;

GoRouter createRouter(AuthBloc authBloc) {
  return GoRouter(
    initialLocation: '/',
    refreshListenable: StreamToListenable([
      authBloc.stream,
    ]),
    redirect: (context, state) {
      final status = authBloc.state.status;

      if (status == AuthStatus.unauthenticated) {
        return '/login';
      }
      if (status == AuthStatus.authenticated) {
        return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}

class StreamToListenable extends ChangeNotifier {
  late final List<StreamSubscription> subscriptions;

  StreamToListenable(List<Stream> streams) {
    subscriptions = [];
    for (var e in streams) {
      var s = e.asBroadcastStream().listen(_tt);
      subscriptions.add(s);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    for (var e in subscriptions) {
      e.cancel();
    }
    super.dispose();
  }

  void _tt(event) => notifyListeners();
}

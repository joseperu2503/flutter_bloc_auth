import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_auth/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc_auth/blocs/auth/auth_state.dart';
import 'package:flutter_bloc_auth/screens/details_screen.dart';
import 'package:flutter_bloc_auth/screens/home_screen.dart';
import 'package:flutter_bloc_auth/screens/login_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter createRouter(AuthBloc authBloc) {
  protectedRedirect(BuildContext context, GoRouterState state) {
    final status = authBloc.state.status;

    if (status == AuthStatus.unauthenticated) {
      return '/login';
    }

    return null;
  }

  unprotectedRedirect(BuildContext context, GoRouterState state) {
    final status = authBloc.state.status;

    if (status == AuthStatus.authenticated) {
      return '/home';
    }

    return null;
  }

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: StreamToListenable([
      authBloc.stream,
    ]),
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
        redirect: unprotectedRedirect,
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
        redirect: protectedRedirect,
      ),
      GoRoute(
        path: '/details',
        builder: (context, state) => const DetailsScreen(),
        redirect: protectedRedirect,
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

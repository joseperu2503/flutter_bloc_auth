import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_auth/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc_auth/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthBloc authBloc = AuthBloc();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = createRouter(authBloc);

    return BlocProvider<AuthBloc>(
      create: (context) => authBloc,
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }
}

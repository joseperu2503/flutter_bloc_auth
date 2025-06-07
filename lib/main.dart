import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_auth/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc_auth/blocs/auth/auth_event.dart';
import 'package:flutter_bloc_auth/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthBloc authBloc = AuthBloc();

  @override
  void initState() {
    super.initState();
    authBloc.add(AuthCheckStatus());
  }

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

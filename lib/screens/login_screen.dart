import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_auth/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc_auth/blocs/auth/auth_event.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () =>
                  context.read<AuthBloc>().add(AuthLoginRequested()),
              child: const Text('Login'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text('go protected route'),
            ),
          ),
        ],
      ),
    );
  }
}

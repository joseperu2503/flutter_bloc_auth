// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_auth/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc_auth/blocs/auth/auth_event.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Protected Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.read<AuthBloc>().add(AuthLogoutRequested()),
          child: const Text('Logout'),
        ),
      ),
    );
  }
}

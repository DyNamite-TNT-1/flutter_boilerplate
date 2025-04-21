import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_three/features/auth/presentation/cubit/authentication_cubit.dart';

class SignOutPage extends StatelessWidget {
  const SignOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign out'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<AuthenticationCubit>().signOut();
            Navigator.of(context).pop();
          },
          child: const Text('Sign out'),
        ),
      ),
    );
  }
}

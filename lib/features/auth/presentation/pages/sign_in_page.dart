import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_three/core/common_state.dart';
import 'package:test_three/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:test_three/features/auth/presentation/pages/sign_out_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state.authState.state == CommonState.success) {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => SignOutPage()));
          } else if (state.authState.state == CommonState.failed) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.authState.message)));
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        context.read<AuthenticationCubit>().signInWithEmail(
                          email,
                          password,
                        );
                      },
                      child: const Text('Sign in with Email'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AuthenticationCubit>().signInWithGoogle();
                      },
                      child: const Text('Sign in with Google'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<AuthenticationCubit>()
                            .signInWithBiometric();
                      },
                      child: const Text('Sign in with Biometric'),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                child: Visibility(
                  visible: state.authState.state == CommonState.loading,
                  child: Center(child: CircularProgressIndicator()),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_three/features/auth/presentation/cubit/authentication_cubit.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _enableToast = true;

  // Fluttertoast doen't support for testing.
  // Need disable it when testing.
  @visibleForTesting
  void setEnableToast(bool enable) {
    setState(() {
      _enableToast = enable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listenWhen: (previous, current) {
          return current is AuthenticationFail;
        },
        listener: (context, state) {
          if (_enableToast &&
              state is AuthenticationFail &&
              state.messageError.isNotEmpty) {
            Fluttertoast.showToast(
              msg: state.messageError.trim(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
            );
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
                    // show error message by Text when testing
                    if (!_enableToast &&
                        state is AuthenticationFail &&
                        state.messageError.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          key: const Key('error_text'),
                          state.messageError.trim(),
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
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
                  visible: state is Authenticating,
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

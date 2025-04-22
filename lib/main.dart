import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_three/features/auth/auth_di.dart';
import 'package:test_three/features/auth/domain/usecases/get_cached_user_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_biometric_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_email_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:test_three/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:test_three/features/auth/presentation/pages/sign_in_page.dart';
import 'package:test_three/features/auth/presentation/pages/home_page.dart';
import 'package:test_three/features/notification/notification_di.dart';
import 'package:test_three/features/payment/payment_di.dart';

final getIt = GetIt.instance;

Future<void> initAppDependencies() async {
  // External
  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => prefs);

  // Register feature-specific dependencies
  initAuthDependencies();
  initPaymentDependencies();
  initNotificationDependencies();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppDependencies();
  runApp(const MyAppWrapper());
}

class MyAppWrapper extends StatelessWidget {
  const MyAppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => AuthenticationCubit(
            getCachedUserUseCase: getIt<GetCachedUserUsecase>(),
            signInWithBiometricUsecase: getIt<SignInWithBiometricUsecase>(),
            signInWithEmailUsecase: getIt<SignInWithEmailUsecase>(),
            signInWithGoogleUsecase: getIt<SignInWithGoogleUsecase>(),
            signOutUsecase: getIt<SignOutUsecase>(),
          )..getCachedUser(),
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, authState) {
          if (authState is AuthenticationSuccess) {
            return const HomePage();
          }

          return const SignInPage();
        },
      ),
    );
  }
}

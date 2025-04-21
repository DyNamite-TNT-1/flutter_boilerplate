import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_three/features/auth/data/datasources/local/user_local_storage.dart';
import 'package:test_three/features/auth/data/datasources/remote/biometric_auth_provider.dart';
import 'package:test_three/features/auth/data/datasources/remote/email_password_auth_provider.dart';
import 'package:test_three/features/auth/data/datasources/remote/google_auth_provider.dart';
import 'package:test_three/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:test_three/features/auth/domain/repositories/auth_repository.dart';
import 'package:test_three/features/auth/domain/usecases/get_cached_user_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_biometric_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_email_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_out_usecase.dart';

void initAuthDependencies() {
  final getIt = GetIt.instance;
  // ---------------------------------------------------------------------------
  // DATA Layer
  // ---------------------------------------------------------------------------
  getIt.registerLazySingleton<UserLocalStorage>(
    () => UserLocalStorageImpl(
      sharedPreferences: getIt<SharedPreferences>(),
      secureStorage: FlutterSecureStorage(),
    ),
  );
  getIt.registerLazySingleton<EmailPasswordAuthProvider>(
    () => EmailPasswordAuthProviderImpl(),
  );
  getIt.registerLazySingleton<GoogleAuthProvider>(
    () => GoogleAuthProviderImpl(),
  );
  getIt.registerLazySingleton<BiometricAuthProvider>(
    () => BiometricAuthProviderImpl(),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      userLocalStorage: getIt<UserLocalStorage>(),
      emailProvider: getIt<EmailPasswordAuthProvider>(),
      googleProvider: getIt<GoogleAuthProvider>(),
      biometricProvider: getIt<BiometricAuthProvider>(),
    ),
  );

  // ---------------------------------------------------------------------------
  // DOMAIN Layer
  // ---------------------------------------------------------------------------
  getIt.registerLazySingleton(
    () => GetCachedUserUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton(
    () => SignInWithEmailUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton(
    () => SignInWithGoogleUsecase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton(
    () => SignInWithBiometricUsecase(getIt<AuthRepository>()),
  );
   getIt.registerLazySingleton(
    () => SignOutUsecase(getIt<AuthRepository>()),
  );
}

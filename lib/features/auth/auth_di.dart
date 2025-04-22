import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_three/features/auth/data/datasources/local/user_local_storage.dart';
import 'package:test_three/features/auth/data/datasources/remote/providers/biometric_auth_provider.dart';
import 'package:test_three/features/auth/data/datasources/remote/providers/email_password_auth_provider.dart';
import 'package:test_three/features/auth/data/datasources/remote/providers/google_auth_provider.dart';
import 'package:test_three/features/auth/data/datasources/remote/services/biometric_api_service.dart';
import 'package:test_three/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:test_three/features/auth/domain/repositories/auth_repository.dart';
import 'package:test_three/features/auth/domain/usecases/get_cached_user_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_biometric_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_email_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_out_usecase.dart';

import 'data/datasources/remote/services/email_api_service.dart';
import 'data/datasources/remote/services/google_api_service.dart';

void initAuthDependencies() {
  final getIt = GetIt.instance;
  // ---------------------------------------------------------------------------
  // DATA Layer
  // ---------------------------------------------------------------------------
  getIt.registerLazySingleton<UserLocalStorage>(
    () => UserLocalStorageImpl(sharedPreferences: getIt<SharedPreferences>()),
  );
  getIt.registerLazySingleton<FakeEmailApiService>(() => FakeEmailApiService());
  getIt.registerLazySingleton<EmailPasswordAuthProvider>(
    () => EmailPasswordAuthProviderImpl(getIt<FakeEmailApiService>()),
  );
  getIt.registerLazySingleton<FakeGoogleApiService>(
    () => FakeGoogleApiService(),
  );
  getIt.registerLazySingleton<GoogleAuthProvider>(
    () => GoogleAuthProviderImpl(getIt<FakeGoogleApiService>()),
  );
  getIt.registerLazySingleton<FakeBiometricApiService>(
    () => FakeBiometricApiService(),
  );
  getIt.registerLazySingleton<BiometricAuthProvider>(
    () => BiometricAuthProviderImpl(getIt<FakeBiometricApiService>()),
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
    () => GetCachedUserUsecase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton(
    () => SignInWithEmailUsecase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton(
    () => SignInWithGoogleUsecase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton(
    () => SignInWithBiometricUsecase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton(() => SignOutUsecase(getIt<AuthRepository>()));
}

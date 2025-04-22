import 'package:test_three/features/auth/data/datasources/local/user_local_storage.dart';
import 'package:test_three/features/auth/data/datasources/remote/providers/biometric_auth_provider.dart';
import 'package:test_three/features/auth/data/models/auth_response.dart';
import 'package:test_three/features/auth/domain/entities/user_entity.dart';
import 'package:test_three/features/auth/domain/repositories/auth_repository.dart';

import '../datasources/remote/providers/email_password_auth_provider.dart';
import '../datasources/remote/providers/google_auth_provider.dart';

class AuthRepositoryImpl extends AuthRepository {
  final UserLocalStorage userLocalStorage;
  final EmailPasswordAuthProvider emailProvider;
  final GoogleAuthProvider googleProvider;
  final BiometricAuthProvider biometricProvider;

  AuthRepositoryImpl({
    required this.userLocalStorage,
    required this.emailProvider,
    required this.googleProvider,
    required this.biometricProvider,
  });

  @override
  UserEntity? getCachedUser() {
    final model = userLocalStorage.getUser();
    if (model != null) {
      return UserEntity.fromModel(model);
    }
    return null;
  }

  @override
  Future<AuthResponse> signInWithEmail(String email, String password) async {
    final response = await emailProvider.signIn(email, password);
    if (response.success && response.user != null) {
      await userLocalStorage.saveUser(response.user!);
    }
    return response;
  }

  @override
  Future<AuthResponse> signInWithGoogle() async {
    final response = await googleProvider.signIn();
    if (response.success && response.user != null) {
      await userLocalStorage.saveUser(response.user!);
    }
    return response;
  }

  @override
  Future<AuthResponse> signInWithBiometric() async {
    final response = await biometricProvider.signIn();
    if (response.success && response.user != null) {
      await userLocalStorage.saveUser(response.user!);
    }
    return response;
  }

  @override
  Future<void> signOut() async {
    await userLocalStorage.clearCache();
  }
}

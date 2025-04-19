import 'package:test_three/features/auth/data/datasources/local/user_local_storage.dart';
import 'package:test_three/features/auth/data/datasources/remote/biometric_auth_provider.dart';
import 'package:test_three/features/auth/domain/entities/user_entity.dart';
import 'package:test_three/features/auth/domain/repositories/auth_repository.dart';

import '../datasources/remote/email_password_auth_provider.dart';
import '../datasources/remote/google_auth_provider.dart';

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
    return userLocalStorage.getUser();
  }

  @override
  Future<UserEntity?> signInWithEmail(String email, String password) async {
    return await emailProvider.signIn(email, password);
  }

  @override
  Future<UserEntity?> signInWithGoogle() async {
    return await googleProvider.signIn();
  }

  @override
  Future<UserEntity?> signInWithBiometric() async {
    return await biometricProvider.signIn();
  }
}

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
    final model = userLocalStorage.getUser();
    if (model != null) {
      return UserEntity.fromModel(model);
    }
    return null;
  }

  @override
  Future<UserEntity?> signInWithEmail(String email, String password) async {
    final model = await emailProvider.signIn(email, password);
    if (model != null) {
      return UserEntity.fromModel(model);
    }
    return null;
  }

  @override
  Future<UserEntity?> signInWithGoogle() async {
    final model = await googleProvider.signIn();
    if (model != null) {
      return UserEntity.fromModel(model);
    }
    return null;
  }

  @override
  Future<UserEntity?> signInWithBiometric() async {
    final model = await biometricProvider.signIn();
    if (model != null) {
      return UserEntity.fromModel(model);
    }
    return null;
  }
}

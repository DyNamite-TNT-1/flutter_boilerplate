import 'package:test_three/features/auth/domain/entities/user_entity.dart';

abstract class BiometricAuthProvider {
  Future<UserEntity?> signIn();
  Future<void> signOut();
}

class BiometricAuthProviderImpl implements BiometricAuthProvider {
  @override
  Future<UserEntity?> signIn() {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}

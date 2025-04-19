import 'package:test_three/features/auth/domain/entities/user_entity.dart';

abstract class GoogleAuthProvider {
  Future<UserEntity?> signIn();
  Future<void> signOut();
}

class GoogleAuthProviderImpl implements GoogleAuthProvider {
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

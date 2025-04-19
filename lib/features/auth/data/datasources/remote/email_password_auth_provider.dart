import 'package:test_three/features/auth/domain/entities/user_entity.dart';

abstract class EmailPasswordAuthProvider {
  Future<UserEntity?> signIn(String email, String password);
  Future<void> signOut();
}

class EmailPasswordAuthProviderImpl implements EmailPasswordAuthProvider {
  @override
  Future<UserEntity?> signIn(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}

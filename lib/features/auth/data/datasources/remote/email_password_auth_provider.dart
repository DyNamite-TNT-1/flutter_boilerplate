import 'package:test_three/features/auth/data/models/user_model.dart';

abstract class EmailPasswordAuthProvider {
  Future<UserModel?> signIn(String email, String password);
  Future<void> signOut();
}

class EmailPasswordAuthProviderImpl implements EmailPasswordAuthProvider {
  @override
  Future<UserModel?> signIn(String email, String password) async {
    // TODO: implement login
    return UserModel();
  }

  @override
  Future<void> signOut() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}

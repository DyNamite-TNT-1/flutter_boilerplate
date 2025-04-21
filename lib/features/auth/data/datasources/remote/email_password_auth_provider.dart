import 'package:test_three/features/auth/data/models/user_model.dart';

abstract class EmailPasswordAuthProvider {
  Future<UserModel?> signIn(String email, String password);
}

class EmailPasswordAuthProviderImpl implements EmailPasswordAuthProvider {
  @override
  Future<UserModel?> signIn(String email, String password) async {
    return UserModel();
  }
}

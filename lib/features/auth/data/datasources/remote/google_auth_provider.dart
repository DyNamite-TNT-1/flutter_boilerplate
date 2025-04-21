import 'package:test_three/features/auth/data/models/user_model.dart';

abstract class GoogleAuthProvider {
  Future<UserModel?> signIn();
}

class GoogleAuthProviderImpl implements GoogleAuthProvider {
  @override
  Future<UserModel?> signIn() async {
    // TODO: implement signIn
    return UserModel();
  }
}

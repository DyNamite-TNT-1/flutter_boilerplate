import 'package:test_three/features/auth/data/models/user_model.dart';

abstract class BiometricAuthProvider {
  Future<UserModel?> signIn();
  Future<void> signOut();
}

class BiometricAuthProviderImpl implements BiometricAuthProvider {
  @override
  Future<UserModel?> signIn() async {
    // TODO: implement signIn
    return UserModel();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}

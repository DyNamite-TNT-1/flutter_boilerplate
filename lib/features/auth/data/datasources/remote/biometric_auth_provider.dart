import 'package:test_three/features/auth/data/models/user_model.dart';

abstract class BiometricAuthProvider {
  Future<UserModel?> signIn();
}

class BiometricAuthProviderImpl implements BiometricAuthProvider {
  @override
  Future<UserModel?> signIn() async {
    return UserModel();
  }
}

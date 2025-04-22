import 'package:test_three/features/auth/data/models/auth_response.dart';
import 'package:test_three/features/auth/data/models/user_model.dart';

import '../services/biometric_api_service.dart';

abstract class BiometricAuthProvider {
  Future<AuthResponse> signIn();
}

class BiometricAuthProviderImpl implements BiometricAuthProvider {
  final FakeBiometricApiService apiService;

  BiometricAuthProviderImpl(this.apiService);

  @override
  Future<AuthResponse> signIn() async {
    final result = await apiService.signIn();

    return AuthResponse(
      success: result['success'] as bool,
      message: result['message'] as String,
      user: result['user'] != null
          ? UserModel(
              id: result['user']['id'],
              email: result['user']['email'],
              name: result['user']['name'],
            )
          : null,
    );
  }
}

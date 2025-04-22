import 'package:test_three/features/auth/data/models/auth_response.dart';
import 'package:test_three/features/auth/data/models/user_model.dart';

import '../services/email_api_service.dart';

abstract class EmailPasswordAuthProvider {
  Future<AuthResponse> signIn(String email, String password);
}

class EmailPasswordAuthProviderImpl implements EmailPasswordAuthProvider {
  final FakeEmailApiService apiService;

  EmailPasswordAuthProviderImpl(this.apiService);

  @override
  Future<AuthResponse> signIn(String email, String password) async {
    final result = await apiService.signIn(email, password);

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

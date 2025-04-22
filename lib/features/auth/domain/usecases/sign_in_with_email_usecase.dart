import 'package:test_three/features/auth/data/models/auth_response.dart';
import 'package:test_three/features/auth/domain/repositories/auth_repository.dart';

class SignInWithEmailUsecase {
  final AuthRepository repository;

  SignInWithEmailUsecase(this.repository);

  Future<AuthResponse> call(String email, String password) {
    return repository.signInWithEmail(email, password);
  }
}

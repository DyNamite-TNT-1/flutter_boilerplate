import 'package:test_three/features/auth/data/models/auth_response.dart';
import 'package:test_three/features/auth/domain/repositories/auth_repository.dart';

class SignInWithGoogleUsecase {
  final AuthRepository repository;

  SignInWithGoogleUsecase(this.repository);

  Future<AuthResponse> call() {
    return repository.signInWithGoogle();
  }
}

import 'package:test_three/features/auth/domain/entities/user_entity.dart';
import 'package:test_three/features/auth/domain/repositories/auth_repository.dart';

class SignInWithBiometricUsecase {
  final AuthRepository repository;

  SignInWithBiometricUsecase(this.repository);

  Future<UserEntity?> call() {
    return repository.signInWithBiometric();
  }
}

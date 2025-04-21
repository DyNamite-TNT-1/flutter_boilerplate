import 'package:test_three/features/auth/domain/repositories/auth_repository.dart';

class SignOutUsecase {
  final AuthRepository repository;
  SignOutUsecase(this.repository);

  Future<void> call() async {
    return repository.signOut();
  }
}

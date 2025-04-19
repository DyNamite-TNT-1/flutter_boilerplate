import 'package:test_three/features/auth/domain/entities/user_entity.dart';
import 'package:test_three/features/auth/domain/repositories/auth_repository.dart';

class GetCachedUserUseCase {
  final AuthRepository repository;
  GetCachedUserUseCase(this.repository);

  UserEntity? call() {
    return repository.getCachedUser();
  }
}

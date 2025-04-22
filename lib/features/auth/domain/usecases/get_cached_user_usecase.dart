import 'package:test_three/features/auth/domain/entities/user_entity.dart';
import 'package:test_three/features/auth/domain/repositories/auth_repository.dart';

class GetCachedUserUsecase {
  final AuthRepository repository;
  GetCachedUserUsecase(this.repository);

  UserEntity? call() {
    return repository.getCachedUser();
  }
}

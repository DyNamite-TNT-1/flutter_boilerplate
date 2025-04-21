import 'package:test_three/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  UserEntity? getCachedUser();
  Future<UserEntity?> signInWithEmail(String email, String password);
  Future<UserEntity?> signInWithGoogle();
  Future<UserEntity?> signInWithBiometric();
  Future<void> signOut();
  Future<bool> isAuthenticated();
}

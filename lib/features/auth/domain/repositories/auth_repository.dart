import 'package:test_three/features/auth/data/models/auth_response.dart';
import 'package:test_three/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  UserEntity? getCachedUser();
  Future<AuthResponse> signInWithEmail(String email, String password);
  Future<AuthResponse> signInWithGoogle();
  Future<AuthResponse> signInWithBiometric();
  Future<void> signOut();
}

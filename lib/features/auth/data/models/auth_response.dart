import 'package:test_three/features/auth/data/models/user_model.dart';

class AuthResponse {
  final bool success;
  final String message;
  final UserModel? user;

  AuthResponse({
    required this.success,
    required this.message,
    this.user = const UserModel(),
  });
}

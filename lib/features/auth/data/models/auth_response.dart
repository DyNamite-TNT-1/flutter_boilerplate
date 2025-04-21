import 'package:test_three/features/auth/data/models/user_model.dart';

class AuthResponse {
  final String token;
  final UserModel user;

  AuthResponse({this.token = "", this.user = const UserModel()});
}

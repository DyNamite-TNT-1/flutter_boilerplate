import 'package:equatable/equatable.dart';
import 'package:test_three/features/auth/data/models/user_model.dart';

class UserEntity with EquatableMixin {
  final String id;
  final String name;
  final String email;

  const UserEntity({this.id = "", this.name = "", this.email = ""});

  factory UserEntity.fromModel(UserModel model) {
    return UserEntity(id: model.id, name: model.name, email: model.email);
  }

  @override
  List<Object?> get props => [id, name, email];
}

import 'dart:convert';

import 'package:test_three/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({super.id, super.email, super.name});

  // ---------------------------------------------------------------------------
  // JSON
  // ---------------------------------------------------------------------------
  factory UserModel.fromRawJson(String str) =>
      UserModel.fromMap(json.decode(str));

  String toRawJson() => json.encode(toMap());

  // ---------------------------------------------------------------------------
  // Maps
  // ---------------------------------------------------------------------------
  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(id: json['id'], email: json['email'], name: json['name']);
  }

  Map<String, dynamic> toMap() => {'id': id, 'email': email, 'name': name};
}

import 'package:flutter_test/flutter_test.dart';
import 'package:test_three/features/auth/data/models/user_model.dart';

void main() {
  const user = UserModel(
    id: '123',
    name: 'Test User',
    email: 'test@example.com',
  );

  final userMap = {
    'id': '123',
    'name': 'Test User',
    'email': 'test@example.com',
  };

  group('UserModel', () {
    test('toMap should convert model to correct map', () {
      expect(user.toMap(), equals(userMap));
    });

    test('fromMap should create model from map', () {
      final result = UserModel.fromMap(userMap);
      expect(result, equals(user));
    });

    test('toRawJson / fromRawJson should work correctly', () {
      final jsonStr = user.toRawJson();
      final result = UserModel.fromRawJson(jsonStr);
      expect(result, equals(user));
    });

    test('should compare equal with same values (Equatable)', () {
      final user2 = UserModel(
        id: '123',
        name: 'Test User',
        email: 'test@example.com',
      );
      expect(user, equals(user2));
    });
  });
}

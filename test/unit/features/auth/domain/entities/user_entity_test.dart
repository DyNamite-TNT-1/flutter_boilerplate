import 'package:flutter_test/flutter_test.dart';
import 'package:test_three/features/auth/data/models/user_model.dart';
import 'package:test_three/features/auth/domain/entities/user_entity.dart';

void main() {
  const user = UserModel(
    id: '123',
    name: 'Test User',
    email: 'test@example.com',
  );

  const entityConstant = UserEntity(
    id: '123',
    name: 'Test User',
    email: 'test@example.com',
  );

  group('UserEntity', () {
    test('fromModel should convert UserModel to UserEntity', () {
      final entity = UserEntity.fromModel(user);
      expect(entity.id, user.id);
      expect(entity.name, user.name);
      expect(entity.email, user.email);
      expect(entity, equals(entityConstant));
    });

    test('default constructor should have empty fields', () {
      const emptyEntity = UserEntity();
      expect(emptyEntity.id, '');
      expect(emptyEntity.name, '');
      expect(emptyEntity.email, '');
    });
  });
}

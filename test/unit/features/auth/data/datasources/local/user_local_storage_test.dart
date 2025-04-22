import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_three/features/auth/data/datasources/local/user_local_storage.dart';
import 'package:test_three/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late UserLocalStorageImpl userLocalStorage;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    userLocalStorage = UserLocalStorageImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getUser', () {
    test('should return a UserModel when a valid JSON string is stored', () {
      // Arrange
      const jsonString = '{"id":"user-1","email":"email@test","name":"User Jr"}';
      when(
        () => mockSharedPreferences.getString('_kUser'),
      ).thenReturn(jsonString);

      // Act
      final result = userLocalStorage.getUser();

      // Assert
      verify(() => mockSharedPreferences.getString('_kUser')).called(1);
      expect(result, isA<UserModel>());
      expect(result?.id, "user-1");
      expect(result?.email, "email@test");
      expect(result?.name, 'User Jr');
    });

    test('should return null when no JSON string is stored', () {
      // Arrange
      when(() => mockSharedPreferences.getString('_kUser')).thenReturn(null);

      // Act
      final result = userLocalStorage.getUser();

      // Assert
      verify(() => mockSharedPreferences.getString('_kUser')).called(1);
      expect(result, null);
    });
  });

  group('saveUser', () {
    test(
      'should save a UserModel as a JSON string in SharedPreferences',
      () async {
        // Arrange
        final user = UserModel(id: "user-1", name: 'User Jr');
        when(
          () => mockSharedPreferences.setString('_kUser', user.toRawJson()),
        ).thenAnswer((_) async => true);

        // Act
        await userLocalStorage.saveUser(user);

        // Assert
        verify(
          () => mockSharedPreferences.setString('_kUser', user.toRawJson()),
        ).called(1);
      },
    );

    test('should throw an exception if saving fails', () async {
      // Arrange
      final user = UserModel(id: "user-1", name: 'User Jr');
      when(
        () => mockSharedPreferences.setString('_kUser', user.toRawJson()),
      ).thenThrow(Exception('Failed to save'));

      // Act & Assert
      expect(() => userLocalStorage.saveUser(user), throwsException);
      verify(
        () => mockSharedPreferences.setString('_kUser', user.toRawJson()),
      ).called(1);
    });
  });

  group('clearCache', () {
    test('should remove the user data from SharedPreferences', () async {
      // Arrange
      when(
        () => mockSharedPreferences.remove('_kUser'),
      ).thenAnswer((_) async => true);

      // Act
      await userLocalStorage.clearCache();

      // Assert
      verify(() => mockSharedPreferences.remove('_kUser')).called(1);
    });

    test('should throw an exception if removing fails', () async {
      // Arrange
      when(
        () => mockSharedPreferences.remove('_kUser'),
      ).thenThrow(Exception('Failed to remove'));

      // Act & Assert
      expect(() => userLocalStorage.clearCache(), throwsException);
      verify(() => mockSharedPreferences.remove('_kUser')).called(1);
    });
  });
}

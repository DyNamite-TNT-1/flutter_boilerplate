import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_three/features/auth/domain/entities/user_entity.dart';
import 'package:test_three/features/auth/domain/repositories/auth_repository.dart';
import 'package:test_three/features/auth/domain/usecases/get_cached_user_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late GetCachedUserUsecase getCachedUserUseCase;

  setUpAll(() {
    registerFallbackValue(UserEntity(id: '', email: '', name: ''));
  });

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    getCachedUserUseCase = GetCachedUserUsecase(mockAuthRepository);
  });

  group('GetCachedUserUseCase', () {
    test('should return cached user when exists', () {
      final cachedUser = UserEntity(
        id: '123',
        email: 'test@example.com',
        name: 'Test User',
      );
      when(() => mockAuthRepository.getCachedUser()).thenReturn(cachedUser);

      final result = getCachedUserUseCase();

      expect(result, cachedUser);
      verify(() => mockAuthRepository.getCachedUser()).called(1);
    });

    test('should return null when no cached user exists', () {
      when(() => mockAuthRepository.getCachedUser()).thenReturn(null);

      final result = getCachedUserUseCase();

      expect(result, isNull);
      verify(() => mockAuthRepository.getCachedUser()).called(1);
    });
  });
}

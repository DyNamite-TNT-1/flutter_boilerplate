import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_three/features/auth/domain/repositories/auth_repository.dart';
import 'package:test_three/features/auth/domain/usecases/sign_out_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late SignOutUsecase signOutUsecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signOutUsecase = SignOutUsecase(mockAuthRepository);
  });

  group('SignOutUsecase', () {
    test('should sign out successfully', () async {
      when(() => mockAuthRepository.signOut()).thenAnswer((_) async => {});

      await signOutUsecase();

      verify(() => mockAuthRepository.signOut()).called(1);
    });
  });
}

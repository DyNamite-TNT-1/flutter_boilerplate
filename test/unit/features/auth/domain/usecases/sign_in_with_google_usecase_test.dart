import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_three/features/auth/data/models/auth_response.dart';
import 'package:test_three/features/auth/data/models/user_model.dart';
import 'package:test_three/features/auth/domain/repositories/auth_repository.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_google_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late SignInWithGoogleUsecase signInWithGoogleUsecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signInWithGoogleUsecase = SignInWithGoogleUsecase(mockAuthRepository);
  });

  group('SignInWithGoogleUsecase', () {
    test(
      'should return success AuthRespone when Google sign in successfully',
      () async {
        final authResponse = AuthResponse(
          success: true,
          message: 'Google sign in successful',
          user: UserModel(
            id: '123',
            email: 'test@example.com',
            name: 'Test User',
          ),
        );
        when(
          () => mockAuthRepository.signInWithGoogle(),
        ).thenAnswer((_) async => authResponse);

        final result = await signInWithGoogleUsecase();

        expect(result.success, isTrue);
        expect(result.message, 'Google sign in successful');
        expect(result.user, isA<UserModel>());
        expect(result.user, isNotNull);
        expect(result.user?.id, '123');
        expect(result.user?.email, 'test@example.com');
        expect(result.user?.name, 'Test User');
        verify(() => mockAuthRepository.signInWithGoogle()).called(1);
      },
    );

    test('should return error AuthReponse when Google sign-in fails', () async {
      final authResponse = AuthResponse(
        success: false,
        message: 'Google sign in failed',
        user: null,
      );
      when(
        () => mockAuthRepository.signInWithGoogle(),
      ).thenAnswer((_) async => authResponse);

      final result = await signInWithGoogleUsecase();

      expect(result.success, isFalse);
      expect(result.message, 'Google sign in failed');
      expect(result.user, isNull);
      verify(() => mockAuthRepository.signInWithGoogle()).called(1);
    });
  });
}

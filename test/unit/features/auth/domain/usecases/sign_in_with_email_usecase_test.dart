import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_three/features/auth/data/models/auth_response.dart';
import 'package:test_three/features/auth/data/models/user_model.dart';
import 'package:test_three/features/auth/domain/repositories/auth_repository.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_email_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late SignInWithEmailUsecase signInWithEmailUseCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signInWithEmailUseCase = SignInWithEmailUsecase(mockAuthRepository);
  });

  group('SignInWithEmailUseCase', () {
    test(
      'should return success AuthRespone when email sign in successfully',
      () async {
        final email = 'test@example.com';
        final password = 'password';
        final authResponse = AuthResponse(
          success: true,
          message: 'Successful sign in!',
          user: UserModel(id: '123', email: email, name: 'Test User'),
        );
        when(
          () => mockAuthRepository.signInWithEmail(email, password),
        ).thenAnswer((_) async => authResponse);

        final result = await signInWithEmailUseCase(email, password);

        expect(result.success, isTrue);
        expect(result.message, 'Successful sign in!');
        expect(result.user, isA<UserModel>());
        expect(result.user, isNotNull);
        expect(result.user?.id, '123');
        expect(result.user?.email, 'test@example.com');
        expect(result.user?.name, 'Test User');
        verify(
          () => mockAuthRepository.signInWithEmail(email, password),
        ).called(1);
      },
    );

    test('should return error AuthReponse when email sign-in fails', () async {
      final email = 'test@example.com';
      final password = 'wrongpassword';
      final authResponse = AuthResponse(
        success: false,
        message: 'Invalid credentials',
        user: null,
      );
      when(
        () => mockAuthRepository.signInWithEmail(email, password),
      ).thenAnswer((_) async => authResponse);

      final result = await signInWithEmailUseCase(email, password);

      expect(result.success, isFalse);
      expect(result.message, 'Invalid credentials');
      expect(result.user, isNull);
      verify(
        () => mockAuthRepository.signInWithEmail(email, password),
      ).called(1);
    });
  });
}

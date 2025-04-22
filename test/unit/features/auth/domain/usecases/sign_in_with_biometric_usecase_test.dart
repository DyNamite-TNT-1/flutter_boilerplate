import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_three/features/auth/data/models/auth_response.dart';
import 'package:test_three/features/auth/data/models/user_model.dart';
import 'package:test_three/features/auth/domain/repositories/auth_repository.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_biometric_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late SignInWithBiometricUsecase signInWithBiometricUsecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signInWithBiometricUsecase = SignInWithBiometricUsecase(mockAuthRepository);
  });

  group('SignInWithBiometricUsecase', () {
    test(
      'should return success AuthRespone when biometric sign in successfully',
      () async {
        final authResponse = AuthResponse(
          success: true,
          message: 'Biometric sign in successful',
          user: UserModel(
            id: '123',
            email: 'test@example.com',
            name: 'Test User',
          ),
        );
        when(
          () => mockAuthRepository.signInWithBiometric(),
        ).thenAnswer((_) async => authResponse);

        final result = await signInWithBiometricUsecase();

        expect(result.success, isTrue);
        expect(result.message, 'Biometric sign in successful');
        expect(result.user, isA<UserModel>());
        expect(result.user, isNotNull);
        expect(result.user?.id, '123');
        expect(result.user?.email, 'test@example.com');
        expect(result.user?.name, 'Test User');
        verify(() => mockAuthRepository.signInWithBiometric()).called(1);
      },
    );

    test(
      'should return error AuthReponse when biometric sign-in fails',
      () async {
        final authResponse = AuthResponse(
          success: false,
          message: 'Biometric sign in failed',
          user: null,
        );
        when(
          () => mockAuthRepository.signInWithBiometric(),
        ).thenAnswer((_) async => authResponse);

        final result = await signInWithBiometricUsecase();

        expect(result.success, isFalse);
        expect(result.message, 'Biometric sign in failed');
        expect(result.user, isNull);
        verify(() => mockAuthRepository.signInWithBiometric()).called(1);
      },
    );
  });
}

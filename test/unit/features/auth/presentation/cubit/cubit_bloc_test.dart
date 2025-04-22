import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_three/features/auth/data/models/auth_response.dart';
import 'package:test_three/features/auth/data/models/user_model.dart';
import 'package:test_three/features/auth/domain/entities/user_entity.dart';
import 'package:test_three/features/auth/domain/usecases/get_cached_user_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_biometric_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_email_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:test_three/features/auth/presentation/cubit/authentication_cubit.dart';

class MockGetCachedUserUsecase extends Mock implements GetCachedUserUsecase {}

class MockSignInWithEmailUsecase extends Mock
    implements SignInWithEmailUsecase {}

class MockSignInWithBiometricUsecase extends Mock
    implements SignInWithBiometricUsecase {}

class MockSignInWithGoogleUsecase extends Mock
    implements SignInWithGoogleUsecase {}

class MockSignOutUsecase extends Mock implements SignOutUsecase {}

void main() {
  late AuthenticationCubit cubit;
  late MockGetCachedUserUsecase mockGetCachedUserUsecase;
  late MockSignInWithEmailUsecase mockSignInWithEmailUsecase;
  late MockSignInWithBiometricUsecase mockSignInWithBiometricUsecase;
  late MockSignInWithGoogleUsecase mockSignInWithGoogleUsecase;
  late MockSignOutUsecase mockSignOutUsecase;

  setUp(() {
    mockGetCachedUserUsecase = MockGetCachedUserUsecase();
    mockSignInWithEmailUsecase = MockSignInWithEmailUsecase();
    mockSignInWithBiometricUsecase = MockSignInWithBiometricUsecase();
    mockSignInWithGoogleUsecase = MockSignInWithGoogleUsecase();
    mockSignOutUsecase = MockSignOutUsecase();

    cubit = AuthenticationCubit(
      getCachedUserUseCase: mockGetCachedUserUsecase,
      signInWithEmailUsecase: mockSignInWithEmailUsecase,
      signInWithBiometricUsecase: mockSignInWithBiometricUsecase,
      signInWithGoogleUsecase: mockSignInWithGoogleUsecase,
      signOutUsecase: mockSignOutUsecase,
    );
  });

  group('AuthenticationCubit', () {
    test('initial state should be InitialAuthenticationState', () {
      expect(cubit.state, isA<InitialAuthenticationState>());
    });

    group('getCachedUser', () {
      blocTest<AuthenticationCubit, AuthenticationState>(
        'should emit [Authenticating, AuthenticationSuccess] when user is found',
        build: () {
          when(() => mockGetCachedUserUsecase()).thenReturn(
            UserEntity(id: "1", name: "Test User", email: "test@example.com"),
          );
          return cubit;
        },
        act: (cubit) => cubit.getCachedUser(),
        expect: () => [isA<Authenticating>(), isA<AuthenticationSuccess>()],
      );

      blocTest<AuthenticationCubit, AuthenticationState>(
        'should emit [Authenticating, AuthenticationFail] when no user is found',
        build: () {
          when(() => mockGetCachedUserUsecase()).thenReturn(null);
          return cubit;
        },
        act: (cubit) => cubit.getCachedUser(),
        expect: () => [isA<Authenticating>(), isA<AuthenticationFail>()],
      );
    });

    group('signInWithEmail', () {
      blocTest<AuthenticationCubit, AuthenticationState>(
        'should emit [Authenticating, AuthenticationSuccess] when successfully sign-in',
        build: () {
          when(
            () => mockSignInWithEmailUsecase('test@example.com', 'password'),
          ).thenAnswer(
            (_) async => AuthResponse(
              success: true,
              message: 'Signed in successfully',
              user: UserModel(
                id: '1',
                email: 'test@example.com',
                name: 'Test User',
              ),
            ),
          );
          return cubit;
        },
        act: (cubit) => cubit.signInWithEmail('test@example.com', 'password'),
        expect: () => [isA<Authenticating>(), isA<AuthenticationSuccess>()],
      );

      blocTest<AuthenticationCubit, AuthenticationState>(
        'should emit [Authenticating, AuthenticationFail] when sign-in fails',
        build: () {
          when(
            () =>
                mockSignInWithEmailUsecase('test@example.com', 'wrongpassword'),
          ).thenAnswer(
            (_) async => AuthResponse(
              success: false,
              message: 'Invalid credentials',
              user: null,
            ),
          );
          return cubit;
        },
        act:
            (cubit) =>
                cubit.signInWithEmail('test@example.com', 'wrongpassword'),
        expect:
            () => [
              isA<Authenticating>(),
              isA<AuthenticationFail>().having(
                (state) => state.messageError,
                'messageError',
                'Invalid credentials',
              ),
            ],
      );
    });

    group('signInWithBiometric', () {
      blocTest<AuthenticationCubit, AuthenticationState>(
        'should emit [Authenticating, AuthenticationSuccess] when biometric successfully sign-in',
        build: () {
          when(() => mockSignInWithBiometricUsecase()).thenAnswer(
            (_) async => AuthResponse(
              success: true,
              message: 'Signed in successfully',
              user: UserModel(
                id: '1',
                email: 'test@example.com',
                name: 'Test User',
              ),
            ),
          );
          return cubit;
        },
        act: (cubit) => cubit.signInWithBiometric(),
        expect: () => [isA<Authenticating>(), isA<AuthenticationSuccess>()],
      );

      blocTest<AuthenticationCubit, AuthenticationState>(
        'should emit [Authenticating, AuthenticationFail] when biometric sign-in fails',
        build: () {
          when(() => mockSignInWithBiometricUsecase()).thenAnswer(
            (_) async => AuthResponse(
              success: false,
              message: 'Biometric failed',
              user: null,
            ),
          );
          return cubit;
        },
        act: (cubit) => cubit.signInWithBiometric(),
        expect: () => [isA<Authenticating>(), isA<AuthenticationFail>()],
      );
    });

    group('signInWithGoogle', () {
      blocTest<AuthenticationCubit, AuthenticationState>(
        'should emit [Authenticating, AuthenticationSuccess] when Google sign-in is successful',
        build: () {
          when(() => mockSignInWithGoogleUsecase()).thenAnswer(
            (_) async => AuthResponse(
              success: true,
              message: 'Signed in successfully',
              user: UserModel(
                id: '1',
                email: 'test@example.com',
                name: 'Test User',
              ),
            ),
          );
          return cubit;
        },
        act: (cubit) => cubit.signInWithGoogle(),
        expect: () => [isA<Authenticating>(), isA<AuthenticationSuccess>()],
      );

      blocTest<AuthenticationCubit, AuthenticationState>(
        'should emit [Authenticating, AuthenticationFail] when Google sign-in fails',
        build: () {
          when(() => mockSignInWithGoogleUsecase()).thenAnswer(
            (_) async => AuthResponse(
              success: false,
              message: 'Google sign-in failed',
              user: null,
            ),
          );
          return cubit;
        },
        act: (cubit) => cubit.signInWithGoogle(),
        expect: () => [isA<Authenticating>(), isA<AuthenticationFail>()],
      );
    });

    group('signOut', () {
      blocTest<AuthenticationCubit, AuthenticationState>(
        'should emit [AuthenticationFail] after sign out',
        build: () {
          when(() => mockSignOutUsecase()).thenAnswer((_) async {});
          return cubit;
        },
        act: (cubit) => cubit.signOut(),
        expect: () => [isA<AuthenticationFail>()],
      );
    });
  });
}

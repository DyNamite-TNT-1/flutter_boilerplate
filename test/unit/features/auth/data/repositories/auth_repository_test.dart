import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_three/features/auth/data/datasources/local/user_local_storage.dart';
import 'package:test_three/features/auth/data/datasources/remote/providers/biometric_auth_provider.dart';
import 'package:test_three/features/auth/data/datasources/remote/providers/email_password_auth_provider.dart';
import 'package:test_three/features/auth/data/datasources/remote/providers/google_auth_provider.dart';
import 'package:test_three/features/auth/data/models/auth_response.dart';
import 'package:test_three/features/auth/data/models/user_model.dart';
import 'package:test_three/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:test_three/features/auth/domain/entities/user_entity.dart';

class MockUserLocalStorage extends Mock implements UserLocalStorage {}

class MockEmailPasswordAuthProvider extends Mock
    implements EmailPasswordAuthProvider {}

class MockGoogleAuthProvider extends Mock implements GoogleAuthProvider {}

class MockBiometricAuthProvider extends Mock implements BiometricAuthProvider {}

void main() {
  late MockUserLocalStorage mockUserLocalStorage;
  late MockEmailPasswordAuthProvider mockEmailPasswordAuthProvider;
  late MockGoogleAuthProvider mockGoogleAuthProvider;
  late MockBiometricAuthProvider mockBiometricAuthProvider;
  late AuthRepositoryImpl authRepository;

  setUp(() {
    mockUserLocalStorage = MockUserLocalStorage();
    mockEmailPasswordAuthProvider = MockEmailPasswordAuthProvider();
    mockGoogleAuthProvider = MockGoogleAuthProvider();
    mockBiometricAuthProvider = MockBiometricAuthProvider();
    authRepository = AuthRepositoryImpl(
      userLocalStorage: mockUserLocalStorage,
      emailProvider: mockEmailPasswordAuthProvider,
      googleProvider: mockGoogleAuthProvider,
      biometricProvider: mockBiometricAuthProvider,
    );
  });

  setUpAll(() {
    registerFallbackValue(UserModel(id: '', email: '', name: ''));
  });

  group('AuthRepositoryImpl', () {
    test('should return cached user when exists', () {
      final cachedUserModel = UserModel(
        id: '123',
        email: 'test@example.com',
        name: 'Test User',
      );
      when(() => mockUserLocalStorage.getUser()).thenReturn(cachedUserModel);

      final result = authRepository.getCachedUser();

      expect(result, isA<UserEntity>());
      expect(result?.id, '123');
      expect(result?.name, 'Test User');
    });

    test('should return null when no cached user exists', () {
      when(() => mockUserLocalStorage.getUser()).thenReturn(null);

      final result = authRepository.getCachedUser();

      expect(result, isNull);
    });

    test('should save user when sign in with email successful', () async {
      final email = 'test@example.com';
      final password = 'password';
      final authResponse = AuthResponse(
        success: true,
        message: 'Successful sign in!',
        user: UserModel(id: '123', email: email, name: 'Test User'),
      );
      when(
        () => mockEmailPasswordAuthProvider.signIn(email, password),
      ).thenAnswer((_) async => authResponse);
      when(
        () => mockUserLocalStorage.saveUser(any()),
      ).thenAnswer((_) async => {});

      final result = await authRepository.signInWithEmail(email, password);

      expect(result.success, isTrue);
      expect(result.user, isNotNull);
      verify(() => mockUserLocalStorage.saveUser(any())).called(1);
    });

    test('should return error when email sign-in fails', () async {
      final email = 'test@example.com';
      final password = 'wrongpassword';
      final authResponse = AuthResponse(
        success: false,
        message: 'Invalid credentials',
        user: null,
      );
      when(
        () => mockEmailPasswordAuthProvider.signIn(email, password),
      ).thenAnswer((_) async => authResponse);

      final result = await authRepository.signInWithEmail(email, password);

      expect(result.success, isFalse);
      expect(result.message, 'Invalid credentials');
      verifyNever(() => mockUserLocalStorage.saveUser(any()));
    });

    test('should save user when sign in with Google successful', () async {
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
        () => mockGoogleAuthProvider.signIn(),
      ).thenAnswer((_) async => authResponse);
      when(
        () => mockUserLocalStorage.saveUser(any()),
      ).thenAnswer((_) async => {});

      final result = await authRepository.signInWithGoogle();

      expect(result.success, isTrue);
      verify(() => mockUserLocalStorage.saveUser(any())).called(1);
    });

    test('should return error when Google sign-in fails', () async {
      final authResponse = AuthResponse(
        success: false,
        message: 'Google sign in failed',
        user: null,
      );
      when(
        () => mockGoogleAuthProvider.signIn(),
      ).thenAnswer((_) async => authResponse);

      final result = await authRepository.signInWithGoogle();

      expect(result.success, isFalse);
      expect(result.message, 'Google sign in failed');
      verifyNever(() => mockUserLocalStorage.saveUser(any()));
    });

    test(
      'should save user when sign in with Biometric successful',
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
          () => mockBiometricAuthProvider.signIn(),
        ).thenAnswer((_) async => authResponse);
        when(
          () => mockUserLocalStorage.saveUser(any()),
        ).thenAnswer((_) async => {});

        final result = await authRepository.signInWithBiometric();

        expect(result.success, isTrue);
        verify(() => mockUserLocalStorage.saveUser(any())).called(1);
      },
    );

    test('should return error when Biometric sign-in fails', () async {
      final authResponse = AuthResponse(
        success: false,
        message: 'Biometric sign in failed',
        user: null,
      );
      when(
        () => mockBiometricAuthProvider.signIn(),
      ).thenAnswer((_) async => authResponse);

      final result = await authRepository.signInWithBiometric();

      expect(result.success, isFalse);
      expect(result.message, 'Biometric sign in failed');
      verifyNever(() => mockUserLocalStorage.saveUser(any()));
    });

    test('should clear cached user when signed out', () async {
      when(() => mockUserLocalStorage.clearCache()).thenAnswer((_) async => {});

      await authRepository.signOut();

      verify(() => mockUserLocalStorage.clearCache()).called(1);
    });
  });
}

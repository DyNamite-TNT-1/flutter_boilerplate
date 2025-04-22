import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_three/features/auth/data/models/auth_response.dart';
import 'package:test_three/features/auth/data/models/user_model.dart';
import 'package:test_three/features/auth/domain/usecases/get_cached_user_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_email_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_biometric_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:test_three/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:test_three/features/auth/presentation/pages/home_page.dart';
import 'package:test_three/features/auth/presentation/pages/sign_in_page.dart';
import 'package:test_three/main.dart';

class MockGetCachedUserUsecase extends Mock implements GetCachedUserUsecase {}

class MockSignInWithEmailUsecase extends Mock
    implements SignInWithEmailUsecase {}

class MockSignOutUsecase extends Mock implements SignOutUsecase {}

class MockSignInWithBiometricUsecase extends Mock
    implements SignInWithBiometricUsecase {}

class MockSignInWithGoogleUsecase extends Mock
    implements SignInWithGoogleUsecase {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late AuthenticationCubit cubit;
  late MockGetCachedUserUsecase mockGetCachedUserUsecase;
  late MockSignInWithEmailUsecase mockSignInWithEmailUsecase;
  late MockSignOutUsecase mockSignOutUsecase;
  late MockSignInWithBiometricUsecase mockSignInWithBiometricUsecase;
  late MockSignInWithGoogleUsecase mockSignInWithGoogleUsecase;

  setUp(() {
    mockGetCachedUserUsecase = MockGetCachedUserUsecase();
    mockSignInWithBiometricUsecase = MockSignInWithBiometricUsecase();
    mockSignInWithEmailUsecase = MockSignInWithEmailUsecase();
    mockSignInWithGoogleUsecase = MockSignInWithGoogleUsecase();
    mockSignOutUsecase = MockSignOutUsecase();

    cubit = AuthenticationCubit(
      getCachedUserUseCase: mockGetCachedUserUsecase,
      signInWithBiometricUsecase: mockSignInWithBiometricUsecase,
      signInWithEmailUsecase: mockSignInWithEmailUsecase,
      signInWithGoogleUsecase: mockSignInWithGoogleUsecase,
      signOutUsecase: mockSignOutUsecase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  Widget createTestApp() {
    return MaterialApp(
      home: BlocProvider<AuthenticationCubit>(
        create: (_) => cubit..getCachedUser(),
        child: MyApp(),
      ),
    );
  }

  group('Authentication Flow', () {
    testWidgets(
      'should at SignIn page when cached user no exist, should navigate to HomePage when successful sign-in email',
      (WidgetTester tester) async {
        // Arrange
        when(() => mockGetCachedUserUsecase()).thenReturn(null);
        when(
          () => mockSignInWithEmailUsecase(any(), any()),
        ).thenAnswer((_) async => AuthResponse(success: true, message: ''));

        // Act
        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        // Find email and password fields
        final emailField = find.byType(TextField).at(0);
        final passwordField = find.byType(TextField).at(1);
        final signInButton = find.text('Sign in with Email');

        // Enter credentials and tap the button
        await tester.enterText(emailField, 'test@example.com');
        await tester.enterText(passwordField, 'password123');
        await tester.tap(signInButton);
        await tester.pumpAndSettle();

        // Assert
        expect(find.byType(HomePage), findsOneWidget);
        expect(find.byType(SignInPage), findsNothing);
        verify(
          () => mockSignInWithEmailUsecase('test@example.com', 'password123'),
        ).called(1);
      },
    );

    testWidgets(
      'should at SignIn page when cached user no exist, should show error message when failed sign-in email',
      (WidgetTester tester) async {
        // Arrange
        when(() => mockGetCachedUserUsecase()).thenReturn(null);
        when(() => mockSignInWithEmailUsecase(any(), any())).thenAnswer(
          (_) async =>
              AuthResponse(success: false, message: 'Invalid credentials'),
        );

        // Act
        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        // Turn toast off setEnableToast
        final signInPageState = tester.state<SignInPageState>(
          find.byType(SignInPage),
        );
        signInPageState.setEnableToast(false);

        final emailField = find.byType(TextField).at(0);
        final passwordField = find.byType(TextField).at(1);
        final signInButton = find.text('Sign in with Email');

        await tester.enterText(emailField, 'test@example.com');
        await tester.enterText(passwordField, 'password123');
        await tester.tap(signInButton);
        await tester.pumpAndSettle();

        // Assert
        expect(find.byKey(const Key('error_text')), findsOneWidget);
        expect(find.text('Invalid credentials'), findsOneWidget);
        // Still at SignInPage
        expect(find.byType(SignInPage), findsOneWidget);
        expect(find.byType(HomePage), findsNothing);
        expect(cubit.state, isA<AuthenticationFail>());
        expect(
          (cubit.state as AuthenticationFail).messageError,
          'Invalid credentials',
        );
        verify(
          () => mockSignInWithEmailUsecase('test@example.com', 'password123'),
        ).called(1);
      },
    );

    testWidgets(
      'should at Home Page if cached user is exist and should return to SignInPage when sign-out',
      (WidgetTester tester) async {
        // Arrange
        when(() => mockGetCachedUserUsecase()).thenReturn(UserModel());
        when(
          () => mockSignOutUsecase(),
        ).thenAnswer((_) async => Future.value());

        // Act
        await tester.pumpWidget(createTestApp());
        await tester.pumpAndSettle();

        // Check if stand at HomePage
        expect(find.byType(HomePage), findsOneWidget);
        expect(find.byType(SignInPage), findsNothing);

        final signOutButton = find.text('Sign out');
        await tester.tap(signOutButton);
        await tester.pumpAndSettle();

        // Assert
        // Return to SignInPage
        expect(find.byType(SignInPage), findsOneWidget);
        expect(find.byType(HomePage), findsNothing);
      },
    );
  });
}

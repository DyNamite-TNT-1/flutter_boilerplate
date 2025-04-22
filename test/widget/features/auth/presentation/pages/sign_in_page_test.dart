import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_three/features/auth/data/models/auth_response.dart';
import 'package:test_three/features/auth/domain/usecases/get_cached_user_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_biometric_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_email_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:test_three/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:test_three/features/auth/presentation/pages/sign_in_page.dart';

class MockGetCachedUserUsecase extends Mock implements GetCachedUserUsecase {}

class MockSignInWithBiometricUsecase extends Mock
    implements SignInWithBiometricUsecase {}

class MockSignInWithEmailUsecase extends Mock
    implements SignInWithEmailUsecase {}

class MockSignInWithGoogleUsecase extends Mock
    implements SignInWithGoogleUsecase {}

class MockSignOutUsecase extends Mock implements SignOutUsecase {}

void main() {
  late AuthenticationCubit cubit;
  late MockGetCachedUserUsecase mockGetCachedUserUsecase;
  late MockSignInWithBiometricUsecase mockSignInWithBiometricUsecase;
  late MockSignInWithEmailUsecase mockSignInWithEmailUsecase;
  late MockSignInWithGoogleUsecase mockSignInWithGoogleUsecase;
  late MockSignOutUsecase mockSignOutUsecase;

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

  Widget buildTestableWidget() {
    return MaterialApp(
      home: BlocProvider<AuthenticationCubit>.value(
        value: cubit,
        child: const SignInPage(),
      ),
    );
  }

  group("SignInPage", () {
    testWidgets('renders email and password fields and buttons', (
      WidgetTester tester,
    ) async {
      cubit.emit(InitialAuthenticationState());

      await tester.pumpWidget(buildTestableWidget());

      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);

      expect(find.text('Sign in with Email'), findsOneWidget);
      expect(find.text('Sign in with Google'), findsOneWidget);
      expect(find.text('Sign in with Biometric'), findsOneWidget);
    });

    testWidgets('should show loading indicator when Authenticating', (
      WidgetTester tester,
    ) async {
      cubit.emit(Authenticating());

      await tester.pumpWidget(buildTestableWidget());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('calls signInWithEmail and shows success', (tester) async {
      when(
        () => mockSignInWithEmailUsecase('user@example.com', 'password123'),
      ).thenAnswer(
        (_) async => AuthResponse(success: true, message: "Sign in successful"),
      );

      await tester.pumpWidget(buildTestableWidget());

      await tester.enterText(find.byType(TextField).at(0), 'user@example.com');
      await tester.enterText(find.byType(TextField).at(1), 'password123');
      await tester.tap(find.text('Sign in with Email'));
      await tester.pump();
      await tester.pump();

      expect(cubit.state, isA<AuthenticationSuccess>());
      verify(
        () => mockSignInWithEmailUsecase('user@example.com', 'password123'),
      ).called(1);
    });

    testWidgets('shows error when email is invalid', (tester) async {
      await tester.pumpWidget(buildTestableWidget());

      await tester.enterText(find.byType(TextField).at(0), 'invalid-email');
      await tester.enterText(find.byType(TextField).at(1), 'password123');
      await tester.tap(find.text('Sign in with Email'));
      await tester.pump();

      expect(cubit.state, isA<AuthenticationFail>());
      expect(
        (cubit.state as AuthenticationFail).messageError,
        'Invalid email format.',
      );
    });

    testWidgets('shows error when password is too short', (tester) async {
      await tester.pumpWidget(buildTestableWidget());

      await tester.enterText(find.byType(TextField).at(0), 'user@example.com');
      await tester.enterText(find.byType(TextField).at(1), '123');
      await tester.tap(find.text('Sign in with Email'));
      await tester.pump();

      expect(cubit.state, isA<AuthenticationFail>());
      expect(
        (cubit.state as AuthenticationFail).messageError,
        'Password must be at least 6 characters.',
      );
    });
  });
}

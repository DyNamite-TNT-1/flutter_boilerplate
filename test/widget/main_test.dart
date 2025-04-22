import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_three/main.dart';
import 'package:test_three/features/auth/domain/usecases/get_cached_user_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_biometric_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_email_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:test_three/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:test_three/features/auth/presentation/pages/home_page.dart';
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

  testWidgets('should render SignInPage when state is not authenticated', (
    WidgetTester tester,
  ) async {
    cubit.emit(InitialAuthenticationState());

    // Act
    await tester.pumpWidget(
      BlocProvider.value(value: cubit, child: const MyApp()),
    );

    await tester.pumpAndSettle();

    // Assert
    expect(find.byType(SignInPage), findsOneWidget);
    expect(find.byType(HomePage), findsNothing);
  });

  testWidgets('should render HomePage when state is authenticated', (
    WidgetTester tester,
  ) async {
    cubit.emit(AuthenticationSuccess());

    // Act
    await tester.pumpWidget(
      BlocProvider.value(value: cubit, child: const MyApp()),
    );

    await tester.pumpAndSettle();

    // Assert
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byType(SignInPage), findsNothing);
  });
}

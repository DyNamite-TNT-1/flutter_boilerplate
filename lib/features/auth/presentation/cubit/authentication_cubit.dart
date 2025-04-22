import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_three/core/utils/validator.dart';
import 'package:test_three/features/auth/domain/usecases/get_cached_user_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_biometric_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_email_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_out_usecase.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final GetCachedUserUsecase _getCachedUserUseCase;
  final SignInWithEmailUsecase _signInWithEmailUsecase;
  final SignInWithBiometricUsecase _signInWithBiometricUsecase;
  final SignInWithGoogleUsecase _signInWithGoogleUsecase;
  final SignOutUsecase _signOutUsecase;

  AuthenticationCubit({
    required GetCachedUserUsecase getCachedUserUseCase,
    required SignInWithEmailUsecase signInWithEmailUsecase,
    required SignInWithBiometricUsecase signInWithBiometricUsecase,
    required SignInWithGoogleUsecase signInWithGoogleUsecase,
    required SignOutUsecase signOutUsecase,
  }) : _getCachedUserUseCase = getCachedUserUseCase,
       _signInWithEmailUsecase = signInWithEmailUsecase,
       _signInWithBiometricUsecase = signInWithBiometricUsecase,
       _signInWithGoogleUsecase = signInWithGoogleUsecase,
       _signOutUsecase = signOutUsecase,
       super(InitialAuthenticationState());

  void getCachedUser() {
    emit(Authenticating());
    try {
      final user = _getCachedUserUseCase();
      if (user != null) {
        emit(AuthenticationSuccess());
      } else {
        emit(AuthenticationFail(messageError: ''));
      }
    } catch (e) {
      emit(AuthenticationFail(messageError: e.toString()));
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    if (!Validator.isValidEmail(email)) {
      emit(AuthenticationFail(messageError: 'Invalid email format.'));
      return;
    }

    if (!Validator.isValidPassword(password)) {
      emit(
        AuthenticationFail(
          messageError: 'Password must be at least 6 characters.',
        ),
      );
      return;
    }

    emit(Authenticating());
    try {
      final response = await _signInWithEmailUsecase(email, password);
      if (response.success) {
        emit(AuthenticationSuccess());
      } else {
        emit(AuthenticationFail(messageError: response.message));
      }
    } catch (e) {
      emit(AuthenticationFail(messageError: e.toString()));
    }
  }

  Future<void> signInWithBiometric() async {
    emit(Authenticating());
    try {
      final response = await _signInWithBiometricUsecase();
      if (response.success) {
        emit(AuthenticationSuccess());
      } else {
        emit(AuthenticationFail(messageError: response.message));
      }
    } catch (e) {
      emit(AuthenticationFail(messageError: e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(Authenticating());
    try {
      final response = await _signInWithGoogleUsecase();
      if (response.success) {
        emit(AuthenticationSuccess());
      } else {
        emit(AuthenticationFail(messageError: response.message));
      }
    } catch (e) {
      emit(AuthenticationFail(messageError: e.toString()));
    }
  }

  Future<void> signOut() async {
    await _signOutUsecase();
    emit(AuthenticationFail(messageError: ""));
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_three/core/common_state.dart';
import 'package:test_three/features/auth/domain/usecases/get_cached_user_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_biometric_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_email_usecase.dart';
import 'package:test_three/features/auth/domain/usecases/sign_in_with_google_usecase.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final GetCachedUserUseCase _getCachedUserUseCase;
  final SignInWithEmailUseCase _signInWithEmailUsecase;
  final SignInWithBiometricUsecase _signInWithBiometricUsecase;
  final SignInWithGoogleUsecase _signInWithGoogleUsecase;

  AuthenticationCubit({
    required GetCachedUserUseCase getCachedUserUseCase,
    required SignInWithEmailUseCase signInWithEmailUsecase,
    required SignInWithBiometricUsecase signInWithBiometricUsecase,
    required SignInWithGoogleUsecase signInWithGoogleUsecase,
  }) : _getCachedUserUseCase = getCachedUserUseCase,
       _signInWithEmailUsecase = signInWithEmailUsecase,
       _signInWithBiometricUsecase = signInWithBiometricUsecase,
       _signInWithGoogleUsecase = signInWithGoogleUsecase,
       super(AuthenticationState());

  void getCachedUser() {
    emit(state.copyWith(authState: CommonStateObject.loading()));
    try {
      final user = _getCachedUserUseCase();
      if (user == null) {
        emit((state.copyWith(authState: CommonStateObject.failed(msg: ""))));
      }
      emit((state.copyWith(authState: CommonStateObject.success())));
    } catch (e) {
      emit(
        (state.copyWith(
          authState: CommonStateObject.failed(msg: e.toString()),
        )),
      );
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    emit(state.copyWith(authState: CommonStateObject.loading()));
    try {
      final user = await _signInWithEmailUsecase(email, password);
      if (user == null) {
        emit(
          (state.copyWith(
            authState: CommonStateObject.failed(
              msg: "Sign in failed with Email",
            ),
          )),
        );
      }
      emit((state.copyWith(authState: CommonStateObject.success())));
    } catch (e) {
      emit(
        (state.copyWith(
          authState: CommonStateObject.failed(msg: e.toString()),
        )),
      );
    }
  }

  Future<void> signInWithBiometric() async {
    emit(state.copyWith(authState: CommonStateObject.loading()));
    try {
      final user = await _signInWithBiometricUsecase();
      if (user == null) {
        emit(
          (state.copyWith(
            authState: CommonStateObject.failed(
              msg: "Sign in failed with Biometric",
            ),
          )),
        );
      }
      emit((state.copyWith(authState: CommonStateObject.success())));
    } catch (e) {
      emit(
        (state.copyWith(
          authState: CommonStateObject.failed(msg: e.toString()),
        )),
      );
    }
  }

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(authState: CommonStateObject.loading()));
    try {
      final user = await _signInWithGoogleUsecase();
      if (user == null) {
        emit(
          (state.copyWith(
            authState: CommonStateObject.failed(
              msg: "Sign in failed with Google",
            ),
          )),
        );
      }
      emit((state.copyWith(authState: CommonStateObject.success())));
    } catch (e) {
      emit(
        (state.copyWith(
          authState: CommonStateObject.failed(msg: e.toString()),
        )),
      );
    }
  }
}

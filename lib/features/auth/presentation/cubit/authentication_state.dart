part of 'authentication_cubit.dart';

class AuthenticationState extends Equatable {
  final CommonStateObject authState;

  const AuthenticationState({this.authState = const CommonStateObject()});

  AuthenticationState copyWith({CommonStateObject? authState}) {
    return AuthenticationState(authState: authState ?? this.authState);
  }

  @override
  List<Object?> get props => [authState];
}

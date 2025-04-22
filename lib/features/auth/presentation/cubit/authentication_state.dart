part of 'authentication_cubit.dart';

abstract class AuthenticationState {}

class InitialAuthenticationState extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {}

class Authenticating extends AuthenticationState {}

class AuthenticationFail extends AuthenticationState {
  final String messageError;
  AuthenticationFail({required this.messageError});
}

part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final LoginDTO loginDTO;

  const LoginEvent(this.loginDTO);

  @override
  List<Object> get props => [loginDTO];
}

class GrantGoogleAccessEvent extends AuthEvent {
  const GrantGoogleAccessEvent();

  @override
  List<Object> get props => [];
}

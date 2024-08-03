part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {
  final LoginDTO loginDTO;

  const LoginEvent(this.loginDTO);

  @override
  List<Object> get props => [loginDTO];
}

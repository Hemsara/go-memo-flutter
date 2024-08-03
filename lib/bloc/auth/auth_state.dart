part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthSuccess extends AuthState {
  const AuthSuccess();

  @override
  List<Object> get props => [];
}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error);

  @override
  List<Object> get props => [error];
}

final class AuthLoading extends AuthState {
  const AuthLoading();

  @override
  List<Object> get props => [];
}

final class GoogleAccessLoading extends AuthState {
  const GoogleAccessLoading();

  @override
  List<Object> get props => [];
}

class GoogleAccessSent extends AuthState {
  final Uri googleAccessUri;

  const GoogleAccessSent(this.googleAccessUri);

  @override
  List<Object> get props => [googleAccessUri];
}

class GoogleAccessGranted extends AuthState {
  const GoogleAccessGranted();

  @override
  List<Object> get props => [];
}

class GoogleAccessError extends AuthState {
  final String error;

  const GoogleAccessError(this.error);

  @override
  List<Object> get props => [error];
}

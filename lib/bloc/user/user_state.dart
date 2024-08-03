import 'package:equatable/equatable.dart';
import 'package:gomemo/models/user/user.model.dart';

abstract class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final User user;

  UserLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class UserError extends UserState {
  final String error;

  UserError(this.error);

  @override
  List<Object> get props => [error];
}

import '../database/model.dart';

abstract class UserState {}

class UsersInitial extends UserState {}

class UsersLoading extends UserState {}

class UsersLoaded extends UserState {
  final List<User?> user;

  UsersLoaded(this.user);
}

class UserError extends UserState {
  final String errorMessage;

  UserError(this.errorMessage);
}

part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class LoginSuccessfully extends UserState {
  final String message;
  LoginSuccessfully({this.message});
}
class LoginError extends UserState {
  final String message;
  LoginError({this.message});
}
class LoginLoading extends UserState {}


class EditSuccessfully extends UserState {
  final String message;
  EditSuccessfully({this.message});
}
class EditError extends UserState {
  final String message;
  final int statusCode;
  EditError({this.message,this.statusCode});
}
class UnauthorizedError extends UserState {
  final String message;
  UnauthorizedError({this.message});
}
class EditLoading extends UserState {}

class LogoutSuccessfully extends UserState {
  final String message;
  LogoutSuccessfully({this.message});
}
class LogoutError extends UserState {
  final String message;
  LogoutError({this.message});
}
class LogoutLoading extends UserState {}


part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class RefreshSuccessfully extends HomeState {
  final String message;
  RefreshSuccessfully({this.message});
}
class RefreshError extends HomeState {
  final String message;
  RefreshError({this.message});
}

class GetDetailsSuccessfully extends HomeState {
  final ProfileDetailsResponseModel profileDetailsResponseModel;
  GetDetailsSuccessfully({this.profileDetailsResponseModel});
}
class  GetDetailsError extends HomeState {
  final String message;
  final int statusCode;
  GetDetailsError({this.message,this.statusCode});
}
class GetDetailsLoading extends HomeState{}



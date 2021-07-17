part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class LoginLoading extends HomeState {
  Status status;
  dynamic data;
  String? message;

  LoginLoading.loading() : status = Status.LOADING;
  LoginLoading.completed(this.data) : status = Status.COMPLETED;
  LoginLoading.error(this.message) : status = Status.ERROR;
}

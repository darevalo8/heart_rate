part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {

}
// ignore: must_be_immutable
class LoginLoading extends LoginState{

  Status status;
  dynamic data;
  String? message;

  
  LoginLoading.loading() : status = Status.LOADING;
  LoginLoading.completed(this.data) : status = Status.COMPLETED;
  LoginLoading.error(this.message) : status = Status.ERROR;

}
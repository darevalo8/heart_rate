part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

// ignore: must_be_immutable
class HomeStatus extends HomeState {
  Status status;
  dynamic data;
  String? message;
  String? pyload;

  HomeStatus.loading() : status = Status.LOADING;
  HomeStatus.completed(this.data) : status = Status.COMPLETED;
  HomeStatus.error(this.message) : status = Status.ERROR;
  HomeStatus.notification(this.pyload): status = Status.NOTIFICATION;
}

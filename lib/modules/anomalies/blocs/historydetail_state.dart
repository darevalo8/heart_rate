part of 'historydetail_cubit.dart';

@immutable
abstract class HistorydetailState {}

class HistorydetailInitial extends HistorydetailState {}

class HistoryDetailStatus extends HistorydetailState {
  Status status;
  Map<String,dynamic>? data;
  String? message;

  HistoryDetailStatus.loading() : status = Status.LOADING;
  HistoryDetailStatus.completed(this.data) : status = Status.COMPLETED;
  HistoryDetailStatus.error(this.message) : status = Status.ERROR;
}
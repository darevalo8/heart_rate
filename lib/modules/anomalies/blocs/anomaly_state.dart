part of 'anomaly_cubit.dart';

@immutable
abstract class AnomalyState {}

class AnomalyInitial extends AnomalyState {}

// ignore: must_be_immutable
class AnomalyStatus extends AnomalyState {
  Status status;
  List<Anomaly>? data;
  String? message;

  AnomalyStatus.loading() : status = Status.LOADING;
  AnomalyStatus.completed(this.data) : status = Status.COMPLETED;
  AnomalyStatus.error(this.message) : status = Status.ERROR;
}


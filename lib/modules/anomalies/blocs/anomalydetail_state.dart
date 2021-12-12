part of 'anomalydetail_cubit.dart';

@immutable
abstract class AnomalydetailState {}

class AnomalydetailInitial extends AnomalydetailState {}


class AnomalydetailStatus extends AnomalydetailState {
  Status status;
  Anomaly? data;
  String? message;

  AnomalydetailStatus.loading() : status = Status.LOADING;
  AnomalydetailStatus.succes() : status = Status.SUCCES;
  AnomalydetailStatus.completed(this.data) : status = Status.COMPLETED;
  AnomalydetailStatus.error(this.message) : status = Status.ERROR;
}

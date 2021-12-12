import 'package:bloc/bloc.dart';
import 'package:heart_rate/modules/anomalies/usescases/anomaly_model.dart';
import 'package:heart_rate/modules/anomalies/usescases/anomaly_usecase.dart';
import 'package:heart_rate/src/common/api_fetch.dart';
import 'package:meta/meta.dart';

part 'anomaly_state.dart';

class AnomalyCubit extends Cubit<AnomalyState> {
  final AnomalyUseCase _anomalyUseCae ;
  AnomalyCubit(this._anomalyUseCae) : super(AnomalyInitial());

  void getAnomaly(String anomalyId)async{
    try {
      emit(AnomalyStatus.loading());
      final response = await this._anomalyUseCae.getAnomaly(anomalyId);
      print("CUbit $response");
      // emit(HomeStatus.completed(response));
    } on AppException catch (ex) {
      emit(AnomalyStatus.error(ex.message));
    }
  }

  void getAllAnomaly() async{
    try {
      emit(AnomalyStatus.loading());
      final response = await this._anomalyUseCae.getAllAnomaly();
      emit(AnomalyStatus.completed(response));
      // emit(HomeStatus.completed(response));
    } on AppException catch (ex) {
      emit(AnomalyStatus.error(ex.message));
    }
  }
}

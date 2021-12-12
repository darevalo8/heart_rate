import 'package:bloc/bloc.dart';
import 'package:heart_rate/modules/anomalies/blocs/anomaly_cubit.dart';
import 'package:heart_rate/modules/anomalies/usescases/anomaly_model.dart';
import 'package:heart_rate/modules/anomalies/usescases/anomaly_usecase.dart';
import 'package:heart_rate/src/common/api_fetch.dart';
import 'package:meta/meta.dart';

part 'anomalydetail_state.dart';

class AnomalydetailCubit extends Cubit<AnomalydetailState> {
  AnomalyUseCase _anomalyUseCase;
  AnomalydetailCubit(this._anomalyUseCase) : super(AnomalydetailInitial());


  void init(String anomalyId)async{
    try {
      emit(AnomalydetailStatus.loading());
      final response = await this._anomalyUseCase.getAnomaly(anomalyId);
      print("CUbit $response");
      emit(AnomalydetailStatus.completed(response));
    } on AppException catch (ex) {
      emit(AnomalydetailStatus.error(ex.message));
    }
  }

  void addAnomalyDetail(AnomalyDetail anomalyDetail)async{
    try {
      final response = await this._anomalyUseCase.addAnomalyDetail(anomalyDetail);
      print("CUbit $response");
      emit(AnomalydetailStatus.succes());
  
      // emit(AnomalydetailStatus.completed(response));
    } on AppException catch (ex) {
      emit(AnomalydetailStatus.error(ex.message));
    }
  }

}

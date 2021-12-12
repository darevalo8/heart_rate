import 'package:bloc/bloc.dart';
import 'package:heart_rate/modules/anomalies/usescases/anomaly_usecase.dart';
import 'package:heart_rate/src/common/api_fetch.dart';
import 'package:meta/meta.dart';

part 'historydetail_state.dart';

class HistorydetailCubit extends Cubit<HistorydetailState> {
  final AnomalyUseCase _anomalyUseCae ;
  HistorydetailCubit(this._anomalyUseCae) : super(HistorydetailInitial());



  void getResultData(String anomalyId)async{
    try{
      emit(HistoryDetailStatus.loading());
      final response = await this._anomalyUseCae.getDataresult(anomalyId);
      print("hablamelo menor $response");
      emit(HistoryDetailStatus.completed(response));

    }on AppException catch (ex){
      emit(HistoryDetailStatus.error(ex.message));
    }
  }
}


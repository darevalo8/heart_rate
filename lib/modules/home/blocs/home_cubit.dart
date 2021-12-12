import 'package:bloc/bloc.dart';
import 'package:heart_rate/modules/anomalies/usescases/anomaly_model.dart';
import 'package:heart_rate/modules/anomalies/usescases/anomaly_usecase.dart';
import 'package:heart_rate/modules/home/usecases/usecases.dart';
import 'package:heart_rate/src/common/api_fetch.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeUsecase _homeUsecase;
  AnomalyUseCase _anomalyUseCae;
  HomeCubit(this._homeUsecase, this._anomalyUseCae) : super(HomeInitial());

  void init()async{
    try {
      emit(HomeStatus.loading());
      final response = await this._homeUsecase.getHearRate();
      print("CUbit $response");
      emit(HomeStatus.completed(response));
    } on AppException catch (ex) {
      emit(HomeStatus.error(ex.message));
    }
  }

  void addAnomaliy() async{
    Anomaly anomaly = Anomaly(status: 0, isBradyCardia: 0, isTachyCardia: 1);

    final respuesta = await _anomalyUseCae.createAnomaly(anomaly);
    print("anomalia creeada $respuesta");

  }
  void addAnomaliy2() async{
    Anomaly anomaly = Anomaly(status: 0, isBradyCardia: 1, isTachyCardia: 0);

    final respuesta = await _anomalyUseCae.createAnomaly(anomaly);
    print("anomalia creeada $respuesta");

  }
}

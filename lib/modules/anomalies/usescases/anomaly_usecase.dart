import 'package:heart_rate/modules/anomalies/usescases/anomaly_model.dart';
import 'package:heart_rate/src/common/db_service.dart';
import 'package:heart_rate/src/common/notification_service.dart';

class AnomalyUseCase{
  

  Future<int> createAnomaly(Anomaly anomaly)async{
    final response = await DBProvider.db.insert('anomaly', anomaly.toMap());
    // final anomalias = await DBProvider.db.queryAllRows("anomaly");
    NotificationService().scheduleAlarm(response.toString());
    return response;
  }

  Future<Anomaly> getAnomaly(String anomalyId)async{
    final response = await DBProvider.db.selectQuery('anomaly', 'id', anomalyId);
    
    final Anomaly anomaly = Anomaly.fromDBMap(response[0]);
    print("anomalia $anomaly");
    return anomaly;
  }

  Future<List<Anomaly>?> getAllAnomaly()async{

    final respose = await DBProvider.db.selectOrderAll('anomaly');
    final anomalyList = AnomalyList.fromJsonDbList(respose);
    return anomalyList.anomalyList;
  }

  Future<int> addAnomalyDetail(AnomalyDetail anomalyDetail)async{
    print("hhay que verlo ${anomalyDetail.toMap()}");
    final response = await DBProvider.db.insert('anomaly_detail', anomalyDetail.toMap());
    Map<String, dynamic> data = {"status": 1, "id": anomalyDetail.anomalyId};
    final test = await DBProvider.db.update("anomaly", "id", data);
    print("actualiza $test");
    return response;
  }
  Future<AnomalyDetail> getAnomalyDetail(String anomalyId)async{
    final response = await DBProvider.db.selectQuery('anomaly_detail', 'anomalyid', anomalyId);
    
    final AnomalyDetail anomaly = AnomalyDetail.fromDBMap(response[0]);
    print("anomalia $anomaly");
    return anomaly;
  }

  Future<Map<String,dynamic>> getDataresult(String anomalyId)async{

    final anomaly = await getAnomaly(anomalyId);
    final anomalyDetail = await getAnomalyDetail(anomalyId);
    Map<String, dynamic> data = {"anomalia": anomaly};
    int countBradyCardia =0;
    int countTaquiCardia =0;
    List<String> messages = [];
    if(anomaly.isBradyCardia==1){
      
      if(anomalyDetail.tieneMarcaPasos== 1){
        print("tiene bradicardia");
        countBradyCardia +=1;
        messages.add("Si tienes un marca paso por favor dirigirse al centro médico más cercano.");
      }if(anomalyDetail.hormonaTirodeaBaja == 1){
        print("tiene bradicardia x2");
        messages.add("Si tienes la hormona tirodea baja Por favor dirigirse al centro médico más cercano.");
        countBradyCardia +=1;
      }if(anomalyDetail.tieneFatiga == 1){
        messages.add("Si tienes fatiga, espera un lapso de 10 minutos, si el síntoma persiste consulte su médico.");
        countBradyCardia +=1;
      }if(anomalyDetail.tieneMareoOAturdimiento == 1){
        messages.add("Si tienes mareos o aturdimiento, por favor consulte su médico.");
        countBradyCardia +=1;
      }if(anomalyDetail.tuvoDesmayos ==1){
        messages.add("Si has tenido mas de un desmayo en un lapso de 30 minutos, por favor consultar al médico.");
        countBradyCardia +=1;
      }
    }else if(anomaly.isTachyCardia ==1){
      if(anomalyDetail.tieneAnsiedad == 1){
        messages.add("La ansiedad hace que nuestros latidos se revolucionen más, intenta calmarte.");
        countTaquiCardia +=1;
      }if(anomalyDetail.tuvoAngustia == 1){
        messages.add("La angustia o malas noticias hace que nuestros latidos se revolucionen más, intenta calmarte.");
        countTaquiCardia +=1;
      }if(anomalyDetail.bebeCafeina == 1){
        messages.add("El exceso de cafeína hace que nuestros latidos se revolucionen más, si no puedes respirar visita a un médico.");
        countTaquiCardia +=1;
      }if(anomalyDetail.bebeAlcohol == 1){
        messages.add("Las bebidas alcoholicas hace que nuestros latidos se revolucionen más, si no puedes respirar visita a un médico.");
        countTaquiCardia +=1;
      }if(anomalyDetail.fuma == 1){
        messages.add("Si fumas y sientes que no puedes respirar visita a un médico.");
        countTaquiCardia +=1;
      }if(anomalyDetail.dolorPecho == 1){
        messages.add("Si tienes dolor en el pecho , por favor dirigirse al centro médico más cercano.");
        countTaquiCardia +=1;
      }if(anomalyDetail.dificultadRespirar == 1){
        messages.add("Si tienes dificultad al respirar , por favor dirigirse al centro médico más cercano.");
        countTaquiCardia +=1;
      }if(anomalyDetail.haceEjercicio == 1){
        messages.add("Cuando hacemos ejercicio nuestros latidos pueden llegar a revoluciones muy altas, toma un descanso respira hondo y si sientes difucultad para respirar y dolor en el pecho consulta a un médico.");
        countTaquiCardia +=1;
      }
    }
    if(messages.length == 0){
      messages.add("No tienes ningún problema. :)");
    }
    data["messages"] = messages;
    return data;
  }
}
import 'package:heart_rate/modules/home/usecases/repositories.dart';

class HomeUsecase{
  final _repository = HomeRepository();

  Future<Map<String, dynamic>> getHearRate()async{
    final data = await _repository.fetchHearRate();
    // print("Uses case ${data[0]}");
    return data[0];
  } 
}
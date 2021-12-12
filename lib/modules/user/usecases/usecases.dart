
import 'package:heart_rate/modules/user/usecases/repository.dart';
import 'package:heart_rate/modules/user/user_model.dart';

class UserUsecase{
  final _repository = UserRepository();

  Future<User>getProfile()async{
    final data = await _repository.fetchProfile();
    return data;
  }
}
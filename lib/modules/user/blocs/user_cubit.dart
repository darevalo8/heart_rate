import 'package:bloc/bloc.dart';
import 'package:heart_rate/modules/user/usecases/usecases.dart';
import 'package:heart_rate/modules/user/user_model.dart';
import 'package:heart_rate/src/common/api_fetch.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserUsecase _userUsecase;
  UserCubit(this._userUsecase) : super(UserInitial());

  void getProfile ()async{
    
    try {
      emit(UserStatus.loading());
      final data = await this._userUsecase.getProfile();
      emit(UserStatus.completed(data));
    } on AppException catch (ex) {
      emit(UserStatus.error(ex.message));
    }
    
  }
}

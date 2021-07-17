import 'package:bloc/bloc.dart';
import 'package:heart_rate/modules/auth/domain/usescases.dart';
import 'package:heart_rate/src/common/api_fetch.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase) : super(LoginInitial());
  final LoginUseCase _loginUseCase;
  void login() async {
    print('llega');
    try {
      final response = await this._loginUseCase.login();
      // emit(LoginLoading.loading());
      print('login cubit $response');
      
      if (response) {
        emit(LoginLoading.completed(response));
      }else{
        emit(LoginLoading.error('Ha ocurrido un error'));
      }
      // print('aca estamos: $response');
    } on AppException catch (ex) {
      emit(LoginLoading.error(ex.message));
    }
  }
}

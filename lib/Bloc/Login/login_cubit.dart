import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import '../../Data/Model/Login/Login.dart';
import '../../Repository/LoginRepository/login_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  var logger = Logger();
  LoginRepository loginRepository=LoginRepository();
  LoginCubit() : super(LoginInitial());

  void logIn(String email, String password) {
    loginRepository.logIn(email,password).then((result) => {
      logger.d(result.status.toString()),
      if(result!=null){
        emit(LoginUser(login: result))
      }
    });
  }


}

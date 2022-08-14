import 'dart:io';

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
  void signUp(String name, String email, String phone, String password, File? image) {
    loginRepository.signUp( name,email,phone,password,image).then((value) => {
      if(value !=null){
        emit(LoginUser(login: value))
      }
    });
  }

  void passWordChange(String cureent, String newpass, String confirm, String token) {
    loginRepository.passWordChange(cureent,newpass,confirm,token).then((result) => {
      logger.d(result.status.toString()),
      if(result!=null){
        emit(LoginUser(login: result))
      }
    });
  }

  void updateProfile(String token,String name, String email, String phone, String password, File? image, String id){
    loginRepository.updateProfile( token,name,email,phone,password,image,id).then((value) => {
      if(value !=null){
        emit(ProfileUpdated())
      }
    });
  }

}

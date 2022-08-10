import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:gontop_buyer/Data/Model/RandomUser/RandomUserResponse.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import '../../Data/Model/User/UserResponse.dart';
import '../../Repository/UserRepository/user_repository.dart';



part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserRepository userRepository=UserRepository();
  UserCubit() : super(UserInitial());

  void getAllSeller(String? token,String? role) {
    userRepository.getAlluser(token, role).then((value) => {
      if(value !=null){
        emit(GetAllUser(userResponse: value))
      }
    });
  }

  void createSeller(String? token, String name, String email, String phone, String password, File? image) {
    userRepository.createSeller(token, name,email,phone,password,image).then((value) => {
      if(value !=null){
        emit(UserCreated())
      }
    });
  }

  void getRandomUser(String? token) {
    userRepository.getRandomUser(token).then((value) => {
      if(value !=null){
        emit(GetRandomSeller(userResponse: value))
      }
    });
  }



}

import 'package:bloc/bloc.dart';
import 'package:gontop_buyer/Repository/UserRepository/user_repository.dart';
import 'package:meta/meta.dart';

import '../../Data/Model/User/UserResponse.dart';

part 'friend_state.dart';

class FriendCubit extends Cubit<FriendState> {
  UserRepository userRepository=UserRepository();
  FriendCubit() : super(FriendInitial());

  void getAllUser(String? token,String? role) {
    userRepository.getAlluser(token, role).then((value) => {
      if(value !=null){
        emit(GetAllBuyerUsers(userResponse: value))
      }
    });
  }

  void addRequest(String? token, String? id) {
    userRepository.addRequest(token, id).then((value) => {
      if(value !=null){
        emit(AddrequestSent())
      }
    });
  }

  void getAllRequstedUser(String? token) {}
}

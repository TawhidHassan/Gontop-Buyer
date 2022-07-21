import 'package:bloc/bloc.dart';
import 'package:gontop_buyer/Data/Model/Friend/FriendsList.dart';
import 'package:gontop_buyer/Data/Model/Friend/RequestedUserResponse.dart';
import 'package:gontop_buyer/Repository/UserRepository/user_repository.dart';
import 'package:meta/meta.dart';

import '../../Data/Model/Order/OrderResponse.dart';
import '../../Data/Model/User/UserResponse.dart';
import '../../Repository/OrderRepository/order_repository.dart';

part 'friend_state.dart';

class FriendCubit extends Cubit<FriendState> {
  UserRepository userRepository=UserRepository();
  OrderRepository orderRepository=OrderRepository();
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

  void getAllRequstedUser(String? token) {
    userRepository.getAllRequstedUser(token).then((value) => {
      if(value !=null){
        emit(GetAllRequestedUsers(requestedUserResponse: value))
      }
    });
  }

  void acceptFriendRequest(String? token, String? id, String status) {
    userRepository.acceptFriendRequest(token,id,status).then((value) => {
      if(value !=null){
        emit(requestAcceptReject())
      }
    });
  }

  void getAllFriends(String? token) {
    userRepository.getAllFriends(token).then((value) => {
      if(value !=null){
        emit(GetAllFriends(friendsList: value))
      }
    });
  }

  void unfriend(String? token, String? id) {
    userRepository.unfriend(token,id).then((value) => {
      if(value !=null){
        emit(requestAcceptReject())
      }
    });
  }

  void getUserOrders(String? token, String? userId, String status) {
    orderRepository.getUserOrders(token,userId,status).then((value) {
      if(value!=null){
        emit(OrderHistoryCancel(orderResponse: value));
      }
    });
  }


}

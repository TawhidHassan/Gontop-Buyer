part of 'friend_cubit.dart';

@immutable
abstract class FriendState {}

class FriendInitial extends FriendState {}
class AddrequestSent extends FriendState {}
class requestAcceptReject extends FriendState {}
class GetAllBuyerUsers extends FriendState {
  final UserResponse? userResponse;

  GetAllBuyerUsers({this.userResponse});
}
class GetAllChatUsers extends FriendState {
  final ChatUserResponse? chatUserResponse;

  GetAllChatUsers({this.chatUserResponse});
}
class GetAllRequestedUsers extends FriendState {
  final RequestedUserResponse? requestedUserResponse;

  GetAllRequestedUsers({this.requestedUserResponse});
}
class GetAllFriends extends FriendState {
  final FriendsList? friendsList;

  GetAllFriends({this.friendsList});
}

class OrderHistoryCancel extends FriendState {
  final OrderResponse? orderResponse;

  OrderHistoryCancel({this.orderResponse});
}
class SendMessage extends FriendState {
  final dynamic data;

  SendMessage({this.data});
}
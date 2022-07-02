part of 'friend_cubit.dart';

@immutable
abstract class FriendState {}

class FriendInitial extends FriendState {}
class AddrequestSent extends FriendState {}
class GetAllBuyerUsers extends FriendState {
  final UserResponse? userResponse;

  GetAllBuyerUsers({this.userResponse});
}
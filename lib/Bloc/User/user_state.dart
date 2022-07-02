part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}
class UserCreated extends UserState {}
class GetAllUser extends UserState {
  final UserResponse? userResponse;

  GetAllUser({this.userResponse});
}
class GetRandomSeller extends UserState {
  final RandomUserResponse? userResponse;

  GetRandomSeller({this.userResponse});
}

// ignore_for_file: file_names


import 'package:gontop_buyer/Data/Model/User/User.dart';
import 'package:json_annotation/json_annotation.dart';


part 'FriendsList.g.dart';

@JsonSerializable()
class FriendsList{



  String? status;
  List<User>? friends;


  FriendsList(this.status, this.friends);

  factory FriendsList.fromJson(Map<String,dynamic>json)=>
      _$FriendsListFromJson(json);
  Map<String,dynamic>toJson()=>_$FriendsListToJson(this);
}
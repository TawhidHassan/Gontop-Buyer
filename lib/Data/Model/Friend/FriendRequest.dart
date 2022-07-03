// ignore_for_file: file_names


import 'package:gontop_buyer/Data/Model/User/User.dart';
import 'package:json_annotation/json_annotation.dart';


part 'FriendRequest.g.dart';

@JsonSerializable()
class FriendRequest{

  @JsonKey(name: "_id")
  String? id;
  User? userOne;
  String? userTwo;
  String? request;


  FriendRequest(this.id, this.userOne, this.userTwo, this.request);



  factory FriendRequest.fromJson(Map<String,dynamic>json)=>
      _$FriendRequestFromJson(json);
  Map<String,dynamic>toJson()=>_$FriendRequestToJson(this);
}
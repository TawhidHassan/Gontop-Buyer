// ignore_for_file: file_names

import 'package:gontop_buyer/Data/Model/Friend/FriendRequest.dart';
import 'package:json_annotation/json_annotation.dart';

import '../User/User.dart';



part 'RequestedUserResponse.g.dart';

@JsonSerializable()
class RequestedUserResponse{


  String? status;
  List<FriendRequest>? friends;


  RequestedUserResponse(this.status, this.friends);

  factory RequestedUserResponse.fromJson(Map<String,dynamic>json)=>
      _$RequestedUserResponseFromJson(json);
  Map<String,dynamic>toJson()=>_$RequestedUserResponseToJson(this);
}
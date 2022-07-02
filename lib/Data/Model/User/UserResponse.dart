// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

import 'User.dart';


part 'UserResponse.g.dart';

@JsonSerializable()
class UserResponse{


  String? status;
  int? length;
  List<User>? data;


  UserResponse(this.status, this.length, this.data);

  factory UserResponse.fromJson(Map<String,dynamic>json)=>
      _$UserResponseFromJson(json);
  Map<String,dynamic>toJson()=>_$UserResponseToJson(this);
}
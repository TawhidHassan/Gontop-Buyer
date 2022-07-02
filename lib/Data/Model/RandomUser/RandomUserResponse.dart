// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

import '../User/User.dart';



part 'RandomUserResponse.g.dart';

@JsonSerializable()
class RandomUserResponse{


  String? status;
  List<User>? seller;


  RandomUserResponse(this.status, this.seller);

  factory RandomUserResponse.fromJson(Map<String,dynamic>json)=>
      _$RandomUserResponseFromJson(json);
  Map<String,dynamic>toJson()=>_$RandomUserResponseToJson(this);
}
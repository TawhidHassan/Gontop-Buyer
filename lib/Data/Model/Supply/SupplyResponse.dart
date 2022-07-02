// ignore_for_file: file_names


import 'package:json_annotation/json_annotation.dart';

import 'Supply.dart';


part 'SupplyResponse.g.dart';

@JsonSerializable()
class SupplyResponse{


  String? status;
  List<Supply>? data;


  SupplyResponse(this.status, this.data);

  factory SupplyResponse.fromJson(Map<String,dynamic>json)=>
      _$SupplyResponseFromJson(json);
  Map<String,dynamic>toJson()=>_$SupplyResponseToJson(this);
}
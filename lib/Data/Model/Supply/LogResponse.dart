// ignore_for_file: file_names


import 'package:json_annotation/json_annotation.dart';

import 'Log.dart';


part 'LogResponse.g.dart';

@JsonSerializable()
class LogResponse{


  String? status;
  num? sellerBdt;
  List<Log>? data;


  LogResponse(this.status, this.sellerBdt, this.data);

  factory LogResponse.fromJson(Map<String,dynamic>json)=>
      _$LogResponseFromJson(json);
  Map<String,dynamic>toJson()=>_$LogResponseToJson(this);
}
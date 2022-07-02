// ignore_for_file: file_names
import 'package:json_annotation/json_annotation.dart';

import 'Game.dart';


part 'GameResponse.g.dart';

@JsonSerializable()
class GameResponse{


  String? status;
  List<Game>? data;


  GameResponse(this.status, this.data);

  factory GameResponse.fromJson(Map<String,dynamic>json)=>
      _$GameResponseFromJson(json);
  Map<String,dynamic>toJson()=>_$GameResponseToJson(this);
}
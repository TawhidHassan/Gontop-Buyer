// ignore_for_file: file_names


import 'package:json_annotation/json_annotation.dart';


part 'LeaderBoard.g.dart';

@JsonSerializable()
class LeaderBoard{

  @JsonKey(name: "_id")
  String? id;
  String? name;
  String? image;
  num? price;


  LeaderBoard(this.id, this.name, this.image, this.price);



  factory LeaderBoard.fromJson(Map<String,dynamic>json)=>
      _$LeaderBoardFromJson(json);
  Map<String,dynamic>toJson()=>_$LeaderBoardToJson(this);
}
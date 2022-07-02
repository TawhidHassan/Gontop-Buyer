// ignore_for_file: file_names


import 'package:json_annotation/json_annotation.dart';


part 'Game.g.dart';

@JsonSerializable()
class Game{

  @JsonKey(name: "_id")
  String? id;
  String? gameName;
  String? about;
  String? image;
  String? createdAt;


  Game(this.id, this.gameName, this.about, this.image, this.createdAt);


  @override
  String toString() {
    return 'Game{id: $id, gameName: $gameName, about: $about, image: $image, createdAt: $createdAt}';
  }

  factory Game.fromJson(Map<String,dynamic>json)=>
      _$GameFromJson(json);
  Map<String,dynamic>toJson()=>_$GameToJson(this);
}
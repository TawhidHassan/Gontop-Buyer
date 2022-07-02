// ignore_for_file: file_names


import 'package:json_annotation/json_annotation.dart';


part 'Sliders.g.dart';

@JsonSerializable()
class Sliders{

  @JsonKey(name: "_id")
  String? id;
  String? adsName;
  String? image;
  String? createdAt;


  Sliders(this.id, this.adsName, this.image, this.createdAt);


  @override
  String toString() {
    return 'Slider{id: $id, adsName: $adsName, image: $image, createdAt: $createdAt}';
  }

  factory Sliders.fromJson(Map<String,dynamic>json)=>
      _$SlidersFromJson(json);
  Map<String,dynamic>toJson()=>_$SlidersToJson(this);
}
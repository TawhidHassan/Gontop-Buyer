// ignore_for_file: file_names


import 'package:json_annotation/json_annotation.dart';


part 'Slider.g.dart';

@JsonSerializable()
class Slider{

  @JsonKey(name: "_id")
  String? id;
  String? adsName;
  String? image;
  String? createdAt;


  Slider(this.id, this.adsName, this.image, this.createdAt);


  @override
  String toString() {
    return 'Slider{id: $id, adsName: $adsName, image: $image, createdAt: $createdAt}';
  }

  factory Slider.fromJson(Map<String,dynamic>json)=>
      _$SliderFromJson(json);
  Map<String,dynamic>toJson()=>_$SliderToJson(this);
}
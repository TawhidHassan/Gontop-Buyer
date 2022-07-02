// ignore_for_file: file_names



import 'package:json_annotation/json_annotation.dart';

import 'Slider.dart';


part 'SliderResponse.g.dart';

@JsonSerializable()
class SliderResponse{


  String? status;
  List<Slider>? data;


  SliderResponse(this.status, this.data);

  factory SliderResponse.fromJson(Map<String,dynamic>json)=>
      _$SliderResponseFromJson(json);
  Map<String,dynamic>toJson()=>_$SliderResponseToJson(this);
}
// ignore_for_file: file_names
import 'package:json_annotation/json_annotation.dart';


part 'AdminSupply.g.dart';

@JsonSerializable()
class AdminSupply{


  String? status;
  num? givenBdt;
  num? takenBdt;


  AdminSupply(this.status, this.givenBdt, this.takenBdt);

  factory AdminSupply.fromJson(Map<String,dynamic>json)=>
      _$AdminSupplyFromJson(json);
  Map<String,dynamic>toJson()=>_$AdminSupplyToJson(this);
}
// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

import '../User/User.dart';


part 'Log.g.dart';

@JsonSerializable()
class Log{

  @JsonKey(name: "_id")
  String? id;
  num? givenBdt;
  num? takenBdt;
  num? supplyLogNo;
  User? seller;
  String? createdAt;
  String? note;
  String? supplyStatus;


  Log(this.id, this.givenBdt, this.takenBdt, this.supplyLogNo, this.seller,
      this.createdAt, this.note, this.supplyStatus);


  @override
  String toString() {
    return 'Log{id: $id, givenBdt: $givenBdt, takenBdt: $takenBdt, supplyLogNo: $supplyLogNo, seller: $seller, createdAt: $createdAt, note: $note, supplyStatus: $supplyStatus}';
  }

  factory Log.fromJson(Map<String,dynamic>json)=>
      _$LogFromJson(json);
  Map<String,dynamic>toJson()=>_$LogToJson(this);
}
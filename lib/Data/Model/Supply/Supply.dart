// ignore_for_file: file_names


import 'package:json_annotation/json_annotation.dart';

import '../User/User.dart';


part 'Supply.g.dart';

@JsonSerializable()
class Supply{

  @JsonKey(name: "_id")
  String? id;
  num? totalBalance;
  User? seller;
  String? createdAt;


  Supply(this.id, this.totalBalance, this.seller, this.createdAt);


  @override
  String toString() {
    return 'Supply{id: $id, totalBalance: $totalBalance, seller: $seller, createdAt: $createdAt}';
  }

  factory Supply.fromJson(Map<String,dynamic>json)=>
      _$SupplyFromJson(json);
  Map<String,dynamic>toJson()=>_$SupplyToJson(this);
}
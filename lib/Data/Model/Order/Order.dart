// ignore_for_file: file_names


import 'package:gontop_buyer/Data/Model/Product/Product.dart';
import 'package:gontop_buyer/Data/Model/User/User.dart';
import 'package:json_annotation/json_annotation.dart';


part 'Order.g.dart';

@JsonSerializable()
class Order{

  @JsonKey(name: "_id")
  String? id;
  String? orderStatus;
  String? orderDate;
  num? orderPrice;
  String? buyerId;
  Product? product;
  User? seller;
  String? gameId;
  String? gameName;
  String? createdAt;


  Order(
      {this.id,
      this.orderStatus,
      this.orderDate,
      this.orderPrice,
      this.buyerId,
      this.product,
      this.seller,
      this.gameId,
      this.gameName,
      this.createdAt});

  factory Order.fromJson(Map<String,dynamic>json)=>
      _$OrderFromJson(json);
  Map<String,dynamic>toJson()=>_$OrderToJson(this);
}
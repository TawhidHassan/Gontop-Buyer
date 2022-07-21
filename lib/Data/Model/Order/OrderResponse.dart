// ignore_for_file: file_names


import 'package:gontop_buyer/Data/Model/Order/Order.dart';
import 'package:json_annotation/json_annotation.dart';


part 'OrderResponse.g.dart';

@JsonSerializable()
class OrderResponse{

  String? status;
  List<Order>? order;

  OrderResponse({this.status, this.order});

  factory OrderResponse.fromJson(Map<String,dynamic>json)=>
      _$OrderResponseFromJson(json);
  Map<String,dynamic>toJson()=>_$OrderResponseToJson(this);
}
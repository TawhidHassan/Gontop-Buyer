// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

import 'Product.dart';


part 'ProductResponse.g.dart';

@JsonSerializable()
class ProductResponse{


  String? status;
  List<Product>? data;


  ProductResponse(this.status, this.data);

  factory ProductResponse.fromJson(Map<String,dynamic>json)=>
      _$ProductResponseFromJson(json);
  Map<String,dynamic>toJson()=>_$ProductResponseToJson(this);
}
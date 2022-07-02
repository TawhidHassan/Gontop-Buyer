// ignore_for_file: file_names


import 'package:json_annotation/json_annotation.dart';


part 'Product.g.dart';

@JsonSerializable()
class Product{

  @JsonKey(name: "_id")
  String? id;
  String? productName;
  num? price;
  String? game;
  num? points;
  String? category;
  String? createdAt;
  String? image;


  Product(this.id, this.productName, this.price, this.game, this.points,
      this.category, this.createdAt, this.image);


  @override
  String toString() {
    return 'Product{id: $id, productName: $productName, price: $price, game: $game, points: $points, category: $category, createdAt: $createdAt, image: $image}';
  }

  factory Product.fromJson(Map<String,dynamic>json)=>
      _$ProductFromJson(json);
  Map<String,dynamic>toJson()=>_$ProductToJson(this);
}
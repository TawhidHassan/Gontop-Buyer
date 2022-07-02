// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      json['_id'] as String?,
      json['productName'] as String?,
      json['price'] as num?,
      json['game'] as String?,
      json['points'] as num?,
      json['category'] as String?,
      json['createdAt'] as String?,
      json['image'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      '_id': instance.id,
      'productName': instance.productName,
      'price': instance.price,
      'game': instance.game,
      'points': instance.points,
      'category': instance.category,
      'createdAt': instance.createdAt,
      'image': instance.image,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      json['_id'] as String?,
      json['categoryName'] as String?,
      json['gameId'] as String?,
      json['createdAt'] as String?,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      '_id': instance.id,
      'categoryName': instance.categoryName,
      'gameId': instance.gameId,
      'createdAt': instance.createdAt,
    };

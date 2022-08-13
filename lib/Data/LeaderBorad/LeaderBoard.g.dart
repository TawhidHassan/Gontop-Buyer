// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LeaderBoard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaderBoard _$LeaderBoardFromJson(Map<String, dynamic> json) => LeaderBoard(
      json['_id'] as String?,
      json['name'] as String?,
      json['image'] as String?,
      json['price'] as num?,
    );

Map<String, dynamic> _$LeaderBoardToJson(LeaderBoard instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
    };

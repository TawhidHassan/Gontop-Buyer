// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) => Game(
      json['_id'] as String?,
      json['gameName'] as String?,
      json['about'] as String?,
      json['image'] as String?,
      json['createdAt'] as String?,
    );

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      '_id': instance.id,
      'gameName': instance.gameName,
      'about': instance.about,
      'image': instance.image,
      'createdAt': instance.createdAt,
    };

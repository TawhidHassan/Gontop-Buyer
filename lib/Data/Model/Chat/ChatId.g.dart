// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChatId.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatId _$ChatIdFromJson(Map<String, dynamic> json) => ChatId(
      json['_id'] as String?,
      json['createdAt'] as String?,
      (json['users'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatIdToJson(ChatId instance) => <String, dynamic>{
      '_id': instance.id,
      'createdAt': instance.createdAt,
      'users': instance.users,
    };

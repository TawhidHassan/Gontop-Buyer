// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChatsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatsResponse _$ChatsResponseFromJson(Map<String, dynamic> json) =>
    ChatsResponse(
      json['status'] as String?,
      (json['messages'] as List<dynamic>?)
          ?.map((e) => Chats.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatsResponseToJson(ChatsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'messages': instance.messages,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Chats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chats _$ChatsFromJson(Map<String, dynamic> json) => Chats(
      json['_id'] as String?,
      json['content'] as String?,
      json['sender'] == null
          ? null
          : User.fromJson(json['sender'] as Map<String, dynamic>),
      json['createdAt'] as String?,
    );

Map<String, dynamic> _$ChatsToJson(Chats instance) => <String, dynamic>{
      '_id': instance.id,
      'content': instance.content,
      'sender': instance.sender,
      'createdAt': instance.createdAt,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChatUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatUser _$ChatUserFromJson(Map<String, dynamic> json) => ChatUser(
      json['_id'] as String?,
      json['name'] as String?,
      json['email'] as String?,
      json['role'] as String?,
      json['image'] as String?,
      json['phoneNumber'] as String?,
      json['friendid'] as String?,
      json['online'] as bool?,
      json['chats'] == null
          ? null
          : Chats.fromJson(json['chats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatUserToJson(ChatUser instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
      'image': instance.image,
      'phoneNumber': instance.phoneNumber,
      'friendid': instance.friendid,
      'online': instance.online,
      'chats': instance.chats,
    };

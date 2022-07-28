// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChatUserResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatUserResponse _$ChatUserResponseFromJson(Map<String, dynamic> json) =>
    ChatUserResponse(
      json['status'] as String?,
      (json['user'] as List<dynamic>?)
          ?.map((e) => ChatUser.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatUserResponseToJson(ChatUserResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'user': instance.user,
    };

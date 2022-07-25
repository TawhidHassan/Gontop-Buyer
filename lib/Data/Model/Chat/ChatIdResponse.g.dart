// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChatIdResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatIdResponse _$ChatIdResponseFromJson(Map<String, dynamic> json) =>
    ChatIdResponse(
      json['message'] as String?,
      json['chat'] == null
          ? null
          : ChatId.fromJson(json['chat'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatIdResponseToJson(ChatIdResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'chat': instance.chat,
    };

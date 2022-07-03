// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FriendRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendRequest _$FriendRequestFromJson(Map<String, dynamic> json) =>
    FriendRequest(
      json['_id'] as String?,
      json['userOne'] == null
          ? null
          : User.fromJson(json['userOne'] as Map<String, dynamic>),
      json['userTwo'] as String?,
      json['request'] as String?,
    );

Map<String, dynamic> _$FriendRequestToJson(FriendRequest instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userOne': instance.userOne,
      'userTwo': instance.userTwo,
      'request': instance.request,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequestedUserResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestedUserResponse _$RequestedUserResponseFromJson(
        Map<String, dynamic> json) =>
    RequestedUserResponse(
      json['status'] as String?,
      (json['friends'] as List<dynamic>?)
          ?.map((e) => FriendRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RequestedUserResponseToJson(
        RequestedUserResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'friends': instance.friends,
    };

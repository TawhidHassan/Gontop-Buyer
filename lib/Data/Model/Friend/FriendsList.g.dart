// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FriendsList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendsList _$FriendsListFromJson(Map<String, dynamic> json) => FriendsList(
      json['status'] as String?,
      (json['friends'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FriendsListToJson(FriendsList instance) =>
    <String, dynamic>{
      'status': instance.status,
      'friends': instance.friends,
    };

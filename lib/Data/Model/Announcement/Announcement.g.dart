// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Announcement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Announcement _$AnnouncementFromJson(Map<String, dynamic> json) => Announcement(
      json['_id'] as String?,
      json['likeCount'] as num?,
      json['announcementText'] as String?,
      json['userliked'] as bool?,
      json['createdAt'] as String?,
    );

Map<String, dynamic> _$AnnouncementToJson(Announcement instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'likeCount': instance.likeCount,
      'announcementText': instance.announcementText,
      'userliked': instance.userliked,
      'createdAt': instance.createdAt,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AnnouncementResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnnouncementResponse _$AnnouncementResponseFromJson(
        Map<String, dynamic> json) =>
    AnnouncementResponse(
      json['status'] as String?,
      (json['announcement'] as List<dynamic>?)
          ?.map((e) => Announcement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnnouncementResponseToJson(
        AnnouncementResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'announcement': instance.announcement,
    };

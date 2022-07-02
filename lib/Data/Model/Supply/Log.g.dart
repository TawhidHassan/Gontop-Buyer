// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Log _$LogFromJson(Map<String, dynamic> json) => Log(
      json['_id'] as String?,
      json['givenBdt'] as num?,
      json['takenBdt'] as num?,
      json['supplyLogNo'] as num?,
      json['seller'] == null
          ? null
          : User.fromJson(json['seller'] as Map<String, dynamic>),
      json['createdAt'] as String?,
      json['note'] as String?,
      json['supplyStatus'] as String?,
    );

Map<String, dynamic> _$LogToJson(Log instance) => <String, dynamic>{
      '_id': instance.id,
      'givenBdt': instance.givenBdt,
      'takenBdt': instance.takenBdt,
      'supplyLogNo': instance.supplyLogNo,
      'seller': instance.seller,
      'createdAt': instance.createdAt,
      'note': instance.note,
      'supplyStatus': instance.supplyStatus,
    };

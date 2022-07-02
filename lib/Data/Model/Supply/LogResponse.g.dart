// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LogResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogResponse _$LogResponseFromJson(Map<String, dynamic> json) => LogResponse(
      json['status'] as String?,
      json['sellerBdt'] as num?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => Log.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LogResponseToJson(LogResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'sellerBdt': instance.sellerBdt,
      'data': instance.data,
    };

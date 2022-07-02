// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SupplyResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplyResponse _$SupplyResponseFromJson(Map<String, dynamic> json) =>
    SupplyResponse(
      json['status'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => Supply.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SupplyResponseToJson(SupplyResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

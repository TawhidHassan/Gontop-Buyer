// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AdminSupply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminSupply _$AdminSupplyFromJson(Map<String, dynamic> json) => AdminSupply(
      json['status'] as String?,
      json['givenBdt'] as num?,
      json['takenBdt'] as num?,
    );

Map<String, dynamic> _$AdminSupplyToJson(AdminSupply instance) =>
    <String, dynamic>{
      'status': instance.status,
      'givenBdt': instance.givenBdt,
      'takenBdt': instance.takenBdt,
    };

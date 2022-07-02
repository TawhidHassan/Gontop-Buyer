// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Supply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Supply _$SupplyFromJson(Map<String, dynamic> json) => Supply(
      json['_id'] as String?,
      json['totalBalance'] as num?,
      json['seller'] == null
          ? null
          : User.fromJson(json['seller'] as Map<String, dynamic>),
      json['createdAt'] as String?,
    );

Map<String, dynamic> _$SupplyToJson(Supply instance) => <String, dynamic>{
      '_id': instance.id,
      'totalBalance': instance.totalBalance,
      'seller': instance.seller,
      'createdAt': instance.createdAt,
    };

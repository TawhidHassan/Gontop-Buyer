// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FundTransfer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FundTransfer _$FundTransferFromJson(Map<String, dynamic> json) => FundTransfer(
      json['_id'] as String?,
      json['message'] as String?,
      json['createdAt'] as String?,
      json['transferamount'] as num?,
      json['transferfrom'] == null
          ? null
          : User.fromJson(json['transferfrom'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FundTransferToJson(FundTransfer instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'message': instance.message,
      'createdAt': instance.createdAt,
      'transferamount': instance.transferamount,
      'transferfrom': instance.transferfrom,
    };

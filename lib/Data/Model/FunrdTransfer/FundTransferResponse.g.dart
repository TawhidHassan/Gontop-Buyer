// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FundTransferResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FundTransferResponse _$FundTransferResponseFromJson(
        Map<String, dynamic> json) =>
    FundTransferResponse(
      json['status'] as String?,
      (json['transferamount'] as List<dynamic>?)
          ?.map((e) => FundTransfer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FundTransferResponseToJson(
        FundTransferResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'transferamount': instance.transferamount,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FundResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FundResponse _$FundResponseFromJson(Map<String, dynamic> json) => FundResponse(
      json['status'] as String?,
      (json['depositamount'] as List<dynamic>?)
          ?.map((e) => Fund.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FundResponseToJson(FundResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'depositamount': instance.depositamount,
    };

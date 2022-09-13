// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Fund.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fund _$FundFromJson(Map<String, dynamic> json) => Fund(
      json['_id'] as String?,
      json['paymentStatus'] as String?,
      json['admincutstatus'] as bool?,
      json['depositBalance'] as num?,
      json['seller'] == null
          ? null
          : User.fromJson(json['seller'] as Map<String, dynamic>),
      json['depositor'] == null
          ? null
          : User.fromJson(json['depositor'] as Map<String, dynamic>),
      json['sellerphoneNumber'] as String?,
      json['depositorphoneNumber'] as String?,
      json['transactionId'] as String?,
      json['paymentType'] as String?,
      json['createdAt'] as String?,
    );

Map<String, dynamic> _$FundToJson(Fund instance) => <String, dynamic>{
      '_id': instance.id,
      'paymentStatus': instance.paymentStatus,
      'admincutstatus': instance.admincutstatus,
      'depositBalance': instance.depositBalance,
      'seller': instance.seller,
      'depositor': instance.depositor,
      'sellerphoneNumber': instance.sellerphoneNumber,
      'depositorphoneNumber': instance.depositorphoneNumber,
      'transactionId': instance.transactionId,
      'paymentType': instance.paymentType,
      'createdAt': instance.createdAt,
    };

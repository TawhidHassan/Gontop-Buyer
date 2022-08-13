// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserWalletResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWalletResponse _$UserWalletResponseFromJson(Map<String, dynamic> json) =>
    UserWalletResponse(
      json['status'] as String?,
      json['message'] as String?,
      json['userwallet'] == null
          ? null
          : Wallet.fromJson(json['userwallet'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserWalletResponseToJson(UserWalletResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'userwallet': instance.userwallet,
    };

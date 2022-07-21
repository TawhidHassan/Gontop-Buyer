// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wallet _$WalletFromJson(Map<String, dynamic> json) => Wallet(
      json['_id'] as String?,
      json['credit'] as num?,
      json['currentbalance'] as num?,
      json['debit'] as num?,
    );

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
      '_id': instance.id,
      'credit': instance.credit,
      'currentbalance': instance.currentbalance,
      'debit': instance.debit,
    };

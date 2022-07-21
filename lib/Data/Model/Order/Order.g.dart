// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['_id'] as String?,
      orderStatus: json['orderStatus'] as String?,
      orderDate: json['orderDate'] as String?,
      orderPrice: json['orderPrice'] as num?,
      buyerId: json['buyerId'] as String?,
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      seller: json['seller'] == null
          ? null
          : User.fromJson(json['seller'] as Map<String, dynamic>),
      gameId: json['gameId'] as String?,
      gameName: json['gameName'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      '_id': instance.id,
      'orderStatus': instance.orderStatus,
      'orderDate': instance.orderDate,
      'orderPrice': instance.orderPrice,
      'buyerId': instance.buyerId,
      'product': instance.product,
      'seller': instance.seller,
      'gameId': instance.gameId,
      'gameName': instance.gameName,
      'createdAt': instance.createdAt,
    };

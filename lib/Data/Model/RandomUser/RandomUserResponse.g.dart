// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RandomUserResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RandomUserResponse _$RandomUserResponseFromJson(Map<String, dynamic> json) =>
    RandomUserResponse(
      json['status'] as String?,
      (json['seller'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RandomUserResponseToJson(RandomUserResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'seller': instance.seller,
    };

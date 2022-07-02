// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SliderResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SliderResponse _$SliderResponseFromJson(Map<String, dynamic> json) =>
    SliderResponse(
      json['status'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => Sliders.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SliderResponseToJson(SliderResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LeaderBoardResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaderBoardResponse _$LeaderBoardResponseFromJson(Map<String, dynamic> json) =>
    LeaderBoardResponse(
      json['status'] as String?,
      (json['leaderboard'] as List<dynamic>?)
          ?.map((e) => LeaderBoard.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LeaderBoardResponseToJson(
        LeaderBoardResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'leaderboard': instance.leaderboard,
    };

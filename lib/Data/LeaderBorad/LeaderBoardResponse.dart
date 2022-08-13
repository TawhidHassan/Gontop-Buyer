// ignore_for_file: file_names



import 'package:json_annotation/json_annotation.dart';

import 'LeaderBoard.dart';


part 'LeaderBoardResponse.g.dart';

@JsonSerializable()
class LeaderBoardResponse{

  String? status;
  List<LeaderBoard>? leaderboard;


  LeaderBoardResponse(this.status, this.leaderboard);

  factory LeaderBoardResponse.fromJson(Map<String,dynamic>json)=>
      _$LeaderBoardResponseFromJson(json);
  Map<String,dynamic>toJson()=>_$LeaderBoardResponseToJson(this);
}
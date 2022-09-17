// ignore_for_file: file_names


import 'package:json_annotation/json_annotation.dart';

import 'Announcement.dart';


part 'AnnouncementResponse.g.dart';

@JsonSerializable()
class AnnouncementResponse{


  String? status;
  List<Announcement>? announcement;


  AnnouncementResponse(this.status, this.announcement);


  factory AnnouncementResponse.fromJson(Map<String,dynamic>json)=>
      _$AnnouncementResponseFromJson(json);
  Map<String,dynamic>toJson()=>_$AnnouncementResponseToJson(this);
}
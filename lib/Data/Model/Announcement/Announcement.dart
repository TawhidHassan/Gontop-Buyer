// ignore_for_file: file_names


import 'package:json_annotation/json_annotation.dart';


part 'Announcement.g.dart';

@JsonSerializable()
class Announcement{

  @JsonKey(name: "_id")
  String? id;
  num? likeCount;
  String? announcementText;
  bool? userliked;
  String? createdAt;


  Announcement(this.id, this.likeCount, this.announcementText, this.userliked,
      this.createdAt);

  factory Announcement.fromJson(Map<String,dynamic>json)=>
      _$AnnouncementFromJson(json);
  Map<String,dynamic>toJson()=>_$AnnouncementToJson(this);
}
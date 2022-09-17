part of 'announcement_cubit.dart';

@immutable
abstract class AnnouncementState {}

class AnnouncementInitial extends AnnouncementState {}
class AnnouncementCreate extends AnnouncementState {}

class GetAllAnnouncement extends AnnouncementState {
  final AnnouncementResponse? announcementResponse;

  GetAllAnnouncement({this.announcementResponse});
}

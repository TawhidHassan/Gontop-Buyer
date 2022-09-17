import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Data/Model/Announcement/AnnouncementResponse.dart';
import '../../Repository/CategoryRepository/category_repository.dart';

part 'announcement_state.dart';

class AnnouncementCubit extends Cubit<AnnouncementState> {
  CategoryRepository announcementRepository=CategoryRepository();
  AnnouncementCubit() : super(AnnouncementInitial());

  void getAllAnnouncement(String? token) {
    announcementRepository.getAllAnnouncement(token).then((value) {
      emit(GetAllAnnouncement(announcementResponse: value));
    });
  }

  void createAnnouncement(String? token, String text) {
    announcementRepository.createAnnouncement(token,text).then((value) {
      emit(AnnouncementCreate());
    });
  }


  void deleteAnnouncement(String? token, String id) {
    announcementRepository.deleteAnnouncement(token,id).then((value) {
      emit(AnnouncementCreate());
    });
  }

  void incrementLike(String? token, String id) {
    announcementRepository.incrementLike(token,id).then((value) {

    });
  }

}

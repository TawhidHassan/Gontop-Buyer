import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Data/Model/Chat/ChatsResponse.dart';
import '../../Repository/ChatRepository/chat_repository.dart';

part 'chat_massages_state.dart';

class ChatMassagesCubit extends Cubit<ChatMassagesState> {
  ChatRepository chatRepository=ChatRepository();
  ChatMassagesCubit() : super(ChatMassagesInitial());

  void getChats(String? token, String? id) {
    chatRepository.getChats(token,id).then((value) {
      if(value !=null){
        emit(GetMessage(chatsResponse: value));
      }
    });
  }


}

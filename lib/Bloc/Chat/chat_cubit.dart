import 'package:bloc/bloc.dart';
import 'package:gontop_buyer/Data/Model/Chat/ChatIdResponse.dart';
import 'package:gontop_buyer/Repository/ChatRepository/chat_repository.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatRepository chatRepository=ChatRepository();
  ChatCubit() : super(ChatInitial());

  void getChatId(String? token, String? userid, String? orderID) {
    chatRepository.getChatId(token,userid,orderID).then((value) {
      if(value !=null){
        emit(ChatIdGet(chatIdResponse: value));
      }
    });
  }


}

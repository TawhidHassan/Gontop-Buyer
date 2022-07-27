part of 'chat_massages_cubit.dart';

@immutable
abstract class ChatMassagesState {}

class ChatMassagesInitial extends ChatMassagesState {}

class GetMessage extends ChatMassagesState {
  final ChatsResponse? chatsResponse;

  GetMessage({this.chatsResponse});
}


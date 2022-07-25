part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatIdGet extends ChatState {
  final ChatIdResponse?   chatIdResponse;

  ChatIdGet({this.chatIdResponse});

}

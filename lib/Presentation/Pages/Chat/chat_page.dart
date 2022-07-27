import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:gontop_buyer/Bloc/Chat/chat_cubit.dart';
import 'package:gontop_buyer/Bloc/Friend/friend_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../../Bloc/Chat/chat_massages_cubit.dart';
import '../../../Service/LocalDataBase/localdata.dart';

class ChatPage extends StatefulWidget {
  final String? userid;
  const ChatPage({Key? key, this.userid}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<types.Message> _messages = [];
  types.User? _user;
  types.User? _user2 ;


  String? token;
  String? chatId;

  //storage instance
  LocalDataGet _localDataGet = LocalDataGet();

  getToken() async {
    var tokenx = await _localDataGet.getData();
    setState(() {
      token = tokenx.get('token');
      BlocProvider.of<ChatCubit>(context).getChatId(token,widget.userid);
      // Logger().d(token);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          if(state is ChatIdGet){
            setState(() {
              final data=(state as ChatIdGet).chatIdResponse;
              chatId=data!.chat!.id;
              Logger().e(chatId);
              _user= types.User(id: data.chat!.users![0].id!,firstName: data.chat!.users![0].name! ,imageUrl: data.chat!.users![0].image,);
              _user2= types.User(id: data.chat!.users![1].id!,firstName: data.chat!.users![1].name! ,imageUrl: data.chat!.users![1].image,);
              BlocProvider.of<ChatMassagesCubit>(context).getChats(token,data.chat!.id);

            });
          }

        },
        builder: (context, state) {
          if(state is !ChatIdGet){
            return Center(child: CircularProgressIndicator(),);
          }

          return BlocConsumer<ChatMassagesCubit, ChatMassagesState>(
            listener: (context, state) {
              if(state is GetMessage){
                final data=(state as GetMessage).chatsResponse;
                for(var i=0;i<data!.messages!.length;i++){
                  final DateFormat formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
                  Logger().w(DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(data.messages![i].createdAt!,true));
                  Logger().w(data.messages![i].content!);
                  _messages.add(types.TextMessage(
                    author: _user!.id == data.messages![i].sender!.id! ? _user!:_user2!,
                    createdAt: DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(data.messages![i].createdAt!,true).millisecondsSinceEpoch,
                    id: data.messages![i].id!,
                    text: data.messages![i].content!,
                    showStatus: true,
                  ));
                }
              }
            },
            builder: (context, state) {
              if(state is !GetMessage){
                return Center(child: CircularProgressIndicator(),);
              }
              return Chat(
                  onPreviewDataFetched: _handlePreviewDataFetched,
                  showUserAvatars: true,
                  showUserNames: true,
                  messages: _messages,
                  onSendPressed: _handleSendPressed,
                  user: _user!,
                  usePreviewData:true,
                onAttachmentPressed: _handleImageSelection,

              );
            },
          );
        },
      ),
    );
  }


  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user!,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: randomString(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
      BlocProvider.of<FriendCubit>(context).sendMessageImage(token,chatId,result.path);
    }
  }

  void _handlePreviewDataFetched(
      types.TextMessage message,
      types.PreviewData previewData,
      ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }
  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user!,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
    BlocProvider.of<FriendCubit>(context).sendMessage(token,chatId,message.text);
  }
}
String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

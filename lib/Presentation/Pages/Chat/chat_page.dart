import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../../Bloc/Chat/chat_cubit.dart';
import '../../../Bloc/Chat/chat_massages_cubit.dart';
import '../../../Bloc/Friend/friend_cubit.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Service/LocalDataBase/localdata.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
class ChatPage extends StatefulWidget {
  final String? userid;
  final String? userName;
  final IO.Socket? socket;
  const ChatPage({ this.userid, this.userName, this.socket});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<types.Message> _messages = [];
  types.User? _user;
  types.User? _user2 ;


  String? token;
  String? chatId;
  String? typeingtext;

  //storage instance
  LocalDataGet _localDataGet = LocalDataGet();

  getToken() async {
    var tokenx = await _localDataGet.getData();
    setState(() {
      token = tokenx.get('token');
      BlocProvider.of<ChatCubit>(context).getChatId(token,widget.userid);
      // Logger().d(token);
    });
    socketSetup();
  }

  @override
  void initState() {
    // TODO: implement initState
    getToken();

    super.initState();

  }
  socketSetup(){
    Logger().e("calling");
    types.TextMessage? textMessage;
    types.ImageMessage? imageMessage;
    widget.socket!.on("message recieved", (data) => {
      Logger().w(data),
      data['messagetype']=="image"? imageMessage = types.ImageMessage(
        author: _user2!,
        createdAt: DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(data['createdAt'],true).millisecondsSinceEpoch,
        id: data['_id'],
        size: 0.0,
        name: "",
        uri:  data['image'],
        showStatus: true,
      ): textMessage = types.TextMessage(
        author: _user2!,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        text: data['content'],
      ),

      if(mounted) _addMessage(data['messagetype']=="image"?imageMessage!:textMessage!)
    });
    widget.socket!.on("typing", (room) {
      if(mounted) {
        setState(() {
          typeingtext="Typing...";

        });
      }
    });

    widget.socket!.on("stop typing", (room){
      Logger().e("stopp type listing");
      if(mounted) {
        setState(() {
          typeingtext=null;

        });
      }
    });

    widget.socket!.onConnect((data) {
      Logger().i('Connection established chat page');
      widget.socket!.emit("join chat", chatId);
    });



  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.userName!),
            Text(typeingtext??"",style: TextStyle(fontSize: 9,color: Colors.white),),
          ],
        ),
      ),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          if(state is ChatIdGet){
            setState(() {
              final data=(state as ChatIdGet).chatIdResponse;
              chatId=data!.chat!.id;
              Logger().e(chatId);

              ///join chat room
              widget.socket!.emit("join chat", chatId);

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
                  // Logger().w(DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(data.messages![i].createdAt!,true));
                  data.messages![i].messagetype=="image"?  _messages.add(types.ImageMessage(
                    author: _user!.id == data.messages![i].sender!.id! ? _user!:_user2!,
                    createdAt: DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(data.messages![i].createdAt!,true).millisecondsSinceEpoch,
                    id: data.messages![i].id!,
                    size: 0.0,
                    name: "",
                    uri:  data.messages![i].image!,
                    showStatus: true,
                  )):
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
              return BlocListener<FriendCubit, FriendState>(
                listener: (context, state) {
                  final data=(state as SendMessage).data;
                  ///send socket event for msg
                  Logger().i({data['message'],chatId});
                  widget.socket!.emit("new message", {data['message'],chatId});

                },
                child: Chat(
                  theme:  DefaultChatTheme(
                    inputBackgroundColor: kPrimaryColorx,
                  ),
                  l10n: const ChatL10nEn(
                    inputPlaceholder: 'Type Here',
                  ),
                  onPreviewDataFetched: _handlePreviewDataFetched,
                  showUserAvatars: true,
                  onTextChanged: _ontypeIng,
                  showUserNames: true,
                  messages: _messages,
                  onSendPressed: _handleSendPressed,
                  user: _user!,
                  usePreviewData:true,
                  onAttachmentPressed: _handleImageSelection,
                ),
              );
            },
          );
        },
      ),
    );
  }
  void _ontypeIng(String text) {
    widget.socket!.emit("typing", chatId);
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

  void _handlePreviewDataFetched(types.TextMessage message, types.PreviewData previewData,) {
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
    widget.socket!.emit("stop typing", chatId);
  }
}
String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

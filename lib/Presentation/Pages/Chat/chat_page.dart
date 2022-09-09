import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:gontop_buyer/Data/Model/Order/Order.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../../Bloc/Chat/chat_cubit.dart';
import '../../../Bloc/Chat/chat_massages_cubit.dart';
import '../../../Bloc/Friend/friend_cubit.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Service/LocalDataBase/localdata.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../Orderpage/Component/order_card.dart';
class ChatPage extends StatefulWidget {
  final String? userid;
  final Order? order;
  final String? userName;
  final IO.Socket? socket;
  const ChatPage({ this.userid, this.userName, this.socket, this.order});

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
    Logger().e(widget.order!.orderStatus);
    var tokenx = await _localDataGet.getData();
    setState(() {
      token = tokenx.get('token');
      BlocProvider.of<ChatCubit>(context).getChatId(token,widget.userid,widget.order!.id);
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
            widget.order!.orderStatus=="completed"? const Text("You can't Messages, Order Complete",style: TextStyle(fontSize: 14,color: Colors.redAccent),): Text(widget.userName!),
            Text(typeingtext??"",style: TextStyle(fontSize: 9,color: Colors.white),),
          ],
        ),
        actions: [
          InkWell(
            onTap: (){
              showAlertDialog(context);
            },
            child: Icon(Icons.description),
          )
        ],
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
                  l10n:  ChatL10nEn(
                    inputPlaceholder:widget.order!.orderStatus=="completed"?"You can't Messages, Order Complete": 'Type Here',
                  ),
                  onPreviewDataFetched: _handlePreviewDataFetched,
                  showUserAvatars: true,
                  onTextChanged: _ontypeIng,
                  showUserNames: true,
                  messages: _messages,
                  onSendPressed: _handleSendPressed,
                  sendButtonVisibilityMode:widget.order!.orderStatus=="completed"?SendButtonVisibilityMode.hidden: SendButtonVisibilityMode.editing,
                  user: _user!,
                  usePreviewData:true,
                  onAttachmentPressed:widget.order!.orderStatus=="completed"?(){} :_handleImageSelection,
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




  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Container(
        height: 300,
        width: MediaQuery.of(context).size.width*0.7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Color(0XFFE3E3E3),
                  borderRadius: BorderRadius.circular(12)
              ),
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 12),
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: 'Order ID:  ',
                              children:  <TextSpan>[
                                TextSpan(text: widget.order!.id!.substring(0,8), style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orangeAccent)),
                              ],
                            ),
                          ),
                          Text("Created: "+StringExtension.displayTimeAgoFromTimestamp(widget.order!.createdAt!),style: TextStyle(color: Color(0xFF8D8D8D),fontSize: 11),)
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: 'Total:  ',
                          children:  <TextSpan>[
                            TextSpan(text: widget.order!.orderPrice!.toString()+"  TK", style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF2FB380))),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Text(widget.order!.orderStatus!,style: TextStyle(color: Colors.white,fontSize: 8),),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    color: Color(0xffEDF5FF),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        widget.order!.product!.image!=null&&widget.order!.product!.image!="N/A"?
                        Expanded(
                          flex: 2,
                          child: CircleAvatar(
                            radius: 20.0,
                            backgroundImage:
                            NetworkImage(widget.order!.product!.image!),
                            backgroundColor: Colors.transparent,
                          ),
                        ):Expanded(
                          flex: 2,
                          child: CircleAvatar(
                            radius: 20.0,
                            backgroundImage:
                            AssetImage("assets/images/bkash.png"),
                            backgroundColor: Colors.transparent,
                          ),
                        ),

                        Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.order!.product!.productName!+"("+widget.order!.product!.points.toString()+")"),
                              Text(widget.order!.product!.price!.toString()+" Tk")
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
                padding: const EdgeInsets.all(16.0),
                child:  InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueAccent
                    ),
                    child: Text("Ok",style: TextStyle(color: Color(0XFFffffff),fontSize:16 ),textAlign: TextAlign.center,),
                  ),
                )
            ),
          ],
        ),
      ),
    );
    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
extension StringExtension on String {
  static String displayTimeAgoFromTimestamp(String  timestamp) {
    print(timestamp+"xx");
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(timestamp,true);
    // var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(, true);
    print("dateLocal.toString()");
    var dateLocal = parseDate.toLocal();
    print(dateLocal.toString());
    final year = int.parse(dateLocal.toString().substring(0, 4));
    final month = int.parse(dateLocal.toString().substring(5, 7));
    final day = int.parse(dateLocal.toString().substring(8, 10));
    final hour = int.parse(dateLocal.toString().substring(11, 13));
    final minute = int.parse(dateLocal.toString().substring(14, 16));

    final DateTime videoDate = DateTime(year, month, day, hour, minute);
    final int diffInHours = DateTime.now().difference(videoDate).inHours;

    String timeAgo = '';
    String timeUnit = '';
    int timeValue = 0;

    if (diffInHours < 1) {
      final diffInMinutes = DateTime.now().difference(videoDate).inMinutes;
      timeValue = diffInMinutes;
      timeUnit = 'minute';
    } else if (diffInHours < 24) {
      timeValue = diffInHours;
      timeUnit = 'hour';
    } else if (diffInHours >= 24 && diffInHours < 24 * 7) {
      timeValue = (diffInHours / 24).floor();
      timeUnit = 'day';
    } else if (diffInHours >= 24 * 7 && diffInHours < 24 * 30) {
      timeValue = (diffInHours / (24 * 7)).floor();
      timeUnit = 'week';
    } else if (diffInHours >= 24 * 30 && diffInHours < 24 * 12 * 30) {
      timeValue = (diffInHours / (24 * 30)).floor();
      timeUnit = 'month';
    } else {
      timeValue = (diffInHours / (24 * 365)).floor();
      timeUnit = 'year';
    }

    timeAgo = timeValue.toString() + ' ' + timeUnit;
    timeAgo += timeValue > 1 ? 's' : '';

    return timeAgo + ' ago';
  }
}
String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../Bloc/Friend/friend_cubit.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../../Service/LocalDataBase/localdata.dart';

class SellerListChat extends StatefulWidget {
  const SellerListChat({Key? key}) : super(key: key);

  @override
  _SellerListChatState createState() => _SellerListChatState();
}

class _SellerListChatState extends State<SellerListChat> {
  String? token;

  //storage instance
  LocalDataGet _localDataGet = LocalDataGet();

  getToken() async {
    var tokenx = await _localDataGet.getData();
    setState(() {
      token = tokenx.get('token');
      BlocProvider.of<FriendCubit>(context).getAllUserChat(token);
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
      backgroundColor: kPrimaryColorx,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColorx,
        elevation: 1,
        title: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              const Expanded(
                flex: 18,
                child: Center(
                  child: Text('Seller List', style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: BlocBuilder<FriendCubit, FriendState>(
          builder: (context, state) {
            if(state is !GetAllChatUsers){
              return Center(child: CircularProgressIndicator(color: Colors.white,),);
            }
            final data=(state as GetAllChatUsers).chatUserResponse;
            return ListView.builder(
                itemCount: data!.user!.length,
                itemBuilder:(context,index){
                  return InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, USER_CHAT_PAGE,arguments: {
                        "id":data.user![index].id,
                        "name":data.user![index].name,
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.symmetric(vertical: 4,horizontal: 12),
                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child:data.user![index].image=="N/A"?CircleAvatar(
                                radius:25,
                                child: Text(data.user![index].name!=null?data.user![index].name![0]:"0"),
                              ):
                              CircleAvatar(
                                radius:25,
                                backgroundImage:NetworkImage(data.user![index].image!),
                              )
                          ),
                          Expanded(
                              flex: 8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data.user![index].name??"No Name",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                                  data.user![index].chats!=null? Text(data.user![index].chats!.messagetype=="text"?data.user![index].chats!.content!:"",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 12),):Container(),
                                  data.user![index].chats!=null? Text(data.user![index].chats!.messagetype=="text"?StringExtension.displayTimeAgoFromTimestamp(data.user![index].chats!.createdAt!):"",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal,fontSize: 12),):Container(),

                                ],
                              )
                          ),
                           Expanded(
                              flex: 1,
                              child:CircleAvatar(
                                radius: 5,
                                backgroundColor:data.user![index].online!? Colors.green:Colors.grey,
                              )
                          )
                        ],
                      ),
                    ),
                  );;
                }
            );
          },
        ),
      ),
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
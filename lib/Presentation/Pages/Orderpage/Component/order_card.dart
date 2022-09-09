import 'package:flutter/material.dart';
import 'package:gontop_buyer/Constants/Colors/app_colors.dart';
import 'package:gontop_buyer/Data/Model/Order/Order.dart';
import 'package:intl/intl.dart';

import '../../../../Constants/Strings/app_strings.dart';
class OrderCard extends StatelessWidget {
  final Order? order;
  const OrderCard({Key? key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  RichText(
                    text: TextSpan(
                      text: 'Order ID:  ',
                      style: DefaultTextStyle.of(context).style,
                      children:  <TextSpan>[
                        TextSpan(text: order!.id!.substring(0,8), style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orangeAccent)),
                      ],
                    ),
                  ),
                  Text("Created: "+StringExtension.displayTimeAgoFromTimestamp(order!.createdAt!),style: TextStyle(color: Color(0xFF8D8D8D),fontSize: 11),)
                ],
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, USER_CHAT_PAGE,arguments: {
                    "id":order!.seller!.id!,
                    "name":order!.seller!.name,
                    "order":order!,
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: kPrimaryColorx,
                      borderRadius: BorderRadius.circular(6)
                  ),
                  child: Text("Chat",style: TextStyle(color: Colors.white),),
                ),
              )
            ],
          ),
          const Divider(
            color: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Total:  ',
                  style: DefaultTextStyle.of(context).style,
                  children:  <TextSpan>[
                    TextSpan(text: order!.orderPrice!.toString()+"  TK", style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF2FB380))),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Text(order!.orderStatus!,style: TextStyle(color: Colors.white,fontSize: 8),),
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
                order!.product!.image!=null&&order!.product!.image!="N/A"?
                Expanded(
                  flex: 2,
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundImage:
                    NetworkImage(order!.product!.image!),
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
                      Text(order!.product!.productName!+"("+order!.product!.points.toString()+")"),
                      Text(order!.product!.price!.toString()+" Tk")
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
            ),
            margin: EdgeInsets.symmetric(vertical: 4,horizontal: 0),
            padding: EdgeInsets.all(6),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child:order!.seller!.image=="N/A"||order!.seller!.image==null?CircleAvatar(
                      radius:15,
                      child: Text(order!.seller!.name!=null?order!.seller!.name![0]:"0"),
                    ):
                    CircleAvatar(
                      radius:15,
                      backgroundImage:NetworkImage(order!.seller!.image!),
                    )
                ),
                Expanded(
                    flex: 10,
                    child: Text(order!.seller!.name??"No Name",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),)
                ),

              ],
            ),
          )


        ],
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
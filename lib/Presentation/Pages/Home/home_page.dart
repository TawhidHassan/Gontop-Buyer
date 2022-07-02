
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../Constants/Colors/app_colors.dart';
import 'Component/service_button.dart';
import 'Component/slider.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColorx,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        title:  Align(
          alignment: Alignment.topLeft,
          child: InkWell(
            onTap: (){

            },
            child: Container(
              height: 30,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xFFF88A44)
              ),
              child: Row(
                children: [
                  SvgPicture.asset("assets/icons/shoppingcart.svg"),
                  const Text("My Gontop Balance (3000BDT)",style: TextStyle(
                    fontSize: 14,fontWeight: FontWeight.w600,
                  ),),
                  SizedBox(width: 6,),
                  Container(
                    height: 10,
                    width: 10,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xFF00EA5E)
                    ),
                  )
                ],
              ),
            ),
          ),
        )      ,
        actions: [
          InkWell(
            onTap: (){
            },
            child: Container(
              margin: EdgeInsets.only(right: 18),
              child: const CircleAvatar(
                radius: 20.0,
                backgroundImage:
                AssetImage("assets/images/bkash.png"),
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            const SizedBox(height: 7,),
            Expanded(flex: 5,child: SliderComponenet()),
            const SizedBox(height: 7,),
            Expanded(
              flex:5,
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(2),
                crossAxisSpacing: 0,
                mainAxisSpacing: 16,
                crossAxisCount: 3,
                children: const <Widget>[
                  ServiceButton(title: "Add Fund",assets: "assets/icons/shoppingcart.svg"),
                  ServiceButton(title: "Send Fund",assets: "assets/icons/mailsend.svg"),
                  ServiceButton(title: "My Orders",assets: "assets/icons/receiveicon.svg"),
                  ServiceButton(title: "Leaderboard",assets: "assets/icons/ranking.svg"),
                  ServiceButton(title: "Flash Deal",assets: "assets/icons/flash-sale.svg"),
                  ServiceButton(title: "Help",assets: "assets/icons/leader-bord.svg"),
                ],
              ),
            )



          ],
        ),
      ),
    );
  }
}

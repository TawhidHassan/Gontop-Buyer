
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Constants/Strings/app_strings.dart';
import 'Component/product_list_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                centerTitle: false,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                elevation: 0,
                title:  Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: (){

                    },
                    child: Container(
                      height: 30,
                      width: 190,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xFFF88A44)
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/icons/peoples.svg"),
                          const Text("Online sellers (12)",style: TextStyle(
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
                        AssetImage("assets/images/banFlag.png"),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.white,
              body: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      const SizedBox(height: 18,),


                    ],
                  ),
                ),
              ),
            )
        )
    );
  }
}


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
                      Container(
                        margin: EdgeInsets.only(left: 14),
                        child: const Text('Welcome Admin',style: TextStyle(
                          fontSize: 24,fontWeight: FontWeight.w800,
                        )),
                      ),
                      const SizedBox(height: 18,),
                      Row(
                        children:  [
                          Expanded(
                            flex: 1,
                              child: InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(context, GAME_LIST);
                                  },
                                  child: const HomeButton(title: "Game",image: "assets/icons/games.svg",color: Color(0xFFFEEBEF ),color2: Color(0xFFFA5A7D ),))
                          ),Expanded(
                            flex: 1,
                              child: InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(context, CATEGORY_LIST);
                                  },
                                  child: const HomeButton(title: "categories",image: "assets/icons/category.svg",color: Color(0xFFFFF6E1 ),color2: Color(0xFFFDC741),))
                          ),Expanded(
                            flex: 1,
                              child: InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(context, PRODUCT_LIST);
                                  },
                                  child:const HomeButton(title: "Product",image: "assets/icons/product.svg",color: Color(0xFFE2FDED ),color2: Color(0xFF15EE6C ),))
                          ),
                        ],
                      ),Row(
                        children:  [
                          Expanded(
                            flex: 1,
                              child: InkWell(
                                 onTap: (){
                                   Navigator.pushNamed(context, SELLER_LIST);
                                 },
                                  child:const HomeButton(title: "Sellers",image: "assets/icons/peoples.svg",color: Color(0xFFE1F3FF ),color2: Color(0xFF30AFFC ),))
                          ),Expanded(
                            flex: 1,
                              child: InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(context, BUYER_LIST);
                                  },
                                  child:const HomeButton(title: "Buyers",image: "assets/icons/user.svg",color: Color(0xFFFEEBEF ),color2: Color(0xFFFA5A7D ),))
                          ),Expanded(
                            flex: 1,
                              child: InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(context, SLIDER_LIST);
                                  },
                                  child:const HomeButton(title: "Slider",image: "assets/icons/slider.svg",color: Color(0xFFE2E1FF ),color2: Color(0xFF817CFD ),))
                          ),
                        ],
                      ),
                      Row(
                        children:  [
                          Expanded(
                              flex: 1,
                              child: InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(context, PRODUCT_ASSIGN_SELLER);
                                  },
                                  child:const HomeButton(title: "Assign product",image: "assets/icons/setting.svg",color: Color(0xFFF1E1FF ),color2: Color(0xFFC47CFD ),))
                          ),
                          Expanded(
                              flex: 1,
                              child: InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(context, SUPPLY_MAIN_PAGE);
                                  },
                                  child: const HomeButton(title: "Supply",image: "assets/icons/supply.svg",color: Color(0xFFFFEFE0 ),color2: Color(0xFFFFA959)))
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            )
        )
    );
  }
}

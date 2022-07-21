
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gontop_buyer/Bloc/Wallet/wallet_cubit.dart';
import 'package:hive/hive.dart';

import '../../../Bloc/Game/game_cubit.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../../Service/LocalDataBase/localdata.dart';
import 'Component/service_button.dart';
import 'Component/slider.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? token;
  String? id;

  //storage instance
  LocalDataGet _localDataGet = LocalDataGet();

  getToken() async {
    var tokenx = await _localDataGet.getData();
    setState(() {
      token = tokenx.get('token');
      id = tokenx.get('userId');
      BlocProvider.of<GameCubit>(context).getGames(token);
      BlocProvider.of<WalletCubit>(context).getUserWallet(token,id);
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
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        title:  Align(
          alignment: Alignment.topLeft,
          child: BlocBuilder<WalletCubit, WalletState>(
            builder: (context, state) {
              if(state is !WalletUser){
                return Center(child: CircularProgressIndicator(),);
              }
              final data=(state as WalletUser).walletResponse;
              return InkWell(
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
                       Text("My Gontop Balance ("+data!.userwallet!.currentbalance!.toString()+"Tk)",style: TextStyle(
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
              );
            },
          ),
        )      ,
        actions: [
          InkWell(
            onTap: (){
              logOut(context);
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
      body: SingleChildScrollView(
        child: Container(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              const SizedBox(height: 7,),
              SliderComponenet(),
              const SizedBox(height: 7,),
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.all(2),
                crossAxisSpacing: 0,
                mainAxisSpacing: 16,
                crossAxisCount: 3,
                children:  <Widget>[
                  InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, SELECT_PAYMENT_METHODS);
                      },
                      child: ServiceButton(title: "Add Fund",assets: "assets/icons/wallet.svg")),
                  InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, FRIEND_LIST);
                      },
                      child: ServiceButton(title: "Send Fund",assets: "assets/icons/mailsend.svg")),
                  ServiceButton(title: "My Orders",assets: "assets/icons/receiveicon.svg"),
                  ServiceButton(title: "Leaderboard",assets: "assets/icons/ranking.svg"),
                  ServiceButton(title: "Flash Deal",assets: "assets/icons/flash-sale.svg"),
                  ServiceButton(title: "Help",assets: "assets/icons/leader-bord.svg"),
                ],
              ),

              Container(
                  margin: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                  child: Text("Available Products",style: TextStyle(color: Color(0xFFFF9031),fontSize: 16,fontWeight: FontWeight.bold),)),

              BlocBuilder<GameCubit, GameState>(
                builder: (context, state) {
                  if(state is !GetAllGame){
                    return Center(child: CircularProgressIndicator(color: Colors.white,),);
                  }
                  final data=(state as GetAllGame).gameResponsel;
                  return Container(
                    margin: EdgeInsets.only(left: 16,right: 16),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data!.data!.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:2,mainAxisSpacing: 10,crossAxisSpacing: 10),

                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, GAME_PRODUCTS,arguments: {
                              "id":data.data![index].id!
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(2),
                            height: 81,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(data.data![index].image!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),


            ],
          ),
        ),
      ),
    );
  }
}
void logOut(BuildContext context) async {
  var users = await Hive.openBox('users');
  users.clear();
  Navigator.pushReplacementNamed(context, LOGIN_PAGE);
}

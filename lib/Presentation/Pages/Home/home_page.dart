
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
  String? image;
  String? name;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  //storage instance
  LocalDataGet _localDataGet = LocalDataGet();

  getToken() async {
    var tokenx = await _localDataGet.getData();
    setState(() {
      token = tokenx.get('token');
      id = tokenx.get('userId');
      name = tokenx.get('name');
      image = tokenx.get('image');
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
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh:refreshList,
        child: SingleChildScrollView(
          child: Container(
            color: Color(0XFF494747),
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
                    InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, ORDER_HISTORY_PAGE);
                        },
                        child: ServiceButton(title: "My Orders",assets: "assets/icons/receiveicon.svg")),
                    InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, FUND_TRANSFER_HISTORY_PAGE);
                        },
                        child: ServiceButton(title: "Fund History",assets: "assets/icons/category.svg")),
                    InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, LEADER_BOARD_PAGE);
                        },
                        child: ServiceButton(title: "Leaderboard",assets: "assets/icons/ranking.svg")),
                    // ServiceButton(title: "Flash Deal",assets: "assets/icons/flash-sale.svg"),
                    ServiceButton(title: "Help",assets: "assets/icons/leader-bord.svg"),
                  ],
                ),
                SizedBox(height: 12,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFF343232),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            color: const Color(0xFF343232),
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
                                      "id":data.data![index].id!,
                                      "game":data.data![index],
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
                )


              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Null>refreshList() async{
    setState(() {

    });
    await Future.delayed(const Duration(seconds: 1));
    BlocProvider.of<GameCubit>(context).getGames(token);
    BlocProvider.of<WalletCubit>(context).getUserWallet(token,id);
  }
}
void logOut(BuildContext context) async {
  var users = await Hive.openBox('users');
  users.clear();
  Navigator.pushReplacementNamed(context, LOGIN_PAGE);
}


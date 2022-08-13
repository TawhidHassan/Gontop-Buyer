
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../Bloc/LeaderBoard/leader_board_cubit.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../../Service/LocalDataBase/localdata.dart';

class LeaderBoardPage extends StatefulWidget {

  const LeaderBoardPage({Key? key}) : super(key: key);

  @override
  State<LeaderBoardPage> createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {


  String? token;
  String? userId;

  //storage instance
  LocalDataGet _localDataGet = LocalDataGet();

  getToken() async {
    var tokenx = await _localDataGet.getData();
    setState(() {
      token = tokenx.get('token');
      userId = tokenx.get('userId');
      BlocProvider.of<LeaderBoardCubit>(context).getLeaderBoard(token);
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
    // ScreenUtil.init(context,designSize: const Size(360, 690),);
    return Container(

        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                centerTitle: false,
                  backgroundColor: kPrimaryColorx,
                elevation: 0,
                title: Text("Leader Board")
              ),
              backgroundColor: Color(0xffF6F8FF),
              body: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(8),
                  child: BlocBuilder<LeaderBoardCubit, LeaderBoardState>(
                    builder: (context, state) {
                      if(state is !getAllLeaderBoardusers){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      final data=(state as getAllLeaderBoardusers).leaderBoardResponse;
                      return ListView.builder(
                          itemCount: data!.leaderboard!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: index==0?Colors.orangeAccent:index==1?Colors.blueAccent:index==2?Colors.green:Colors.white,
                              ),
                              margin: EdgeInsets.symmetric(vertical: 4,horizontal: 12),
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child:Text((index+1).toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child:data.leaderboard![index].image=="N/A"?CircleAvatar(
                                        radius:25,
                                        child: Text(data.leaderboard![index].name!=null?data.leaderboard![index].name![0]:"0"),
                                      ):
                                      CircleAvatar(
                                        radius:25,
                                        backgroundImage:NetworkImage(data.leaderboard![index].image!),
                                      )
                                  ),
                                  Expanded(
                                      flex: 7,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(data.leaderboard![index].name??"No Name",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                                          data.leaderboard![index].price!=null? Text("Total: "+data.leaderboard![index].price.toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),):Container(),

                                        ],
                                      )
                                  ),
                                ],
                              ),
                            );
                          }

                      );
                    },
                  )
              )
          ),
        )
    );
  }
}

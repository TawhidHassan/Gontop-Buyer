import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Bloc/Friend/friend_cubit.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../../Service/LocalDataBase/localdata.dart';

class FriendListPage extends StatefulWidget {
  const FriendListPage({Key? key}) : super(key: key);

  @override
  _FriendListPageState createState() => _FriendListPageState();
}

class _FriendListPageState extends State<FriendListPage> {
  String? token;

  //storage instance
  LocalDataGet _localDataGet = LocalDataGet();

  getToken() async {
    var tokenx = await _localDataGet.getData();
    setState(() {
      token = tokenx.get('token');
      BlocProvider.of<FriendCubit>(context).getAllFriends(token);
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
              Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back,color: Colors.white,)
                  )),
              const Expanded(
                flex: 18,
                child: Center(
                  child: Text('Friend List', style: TextStyle(
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
            if(state is !GetAllFriends){
              return Center(child: CircularProgressIndicator(color: Colors.white,),);
            }
            final data=(state as GetAllFriends).friendsList;
            return ListView.builder(
                itemCount: data!.friends!.length,
                itemBuilder:(context,index){
                  return Container(
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.symmetric(vertical: 4,horizontal: 12),
                    padding: EdgeInsets.all(12),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 9,
                          child: InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, SEND_FUND_PAGE,arguments: {
                                "user":data.friends![index]
                              });
                            },
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child:data.friends![index].image=="N/A"?CircleAvatar(
                                      radius:50,
                                      child: Text(data.friends![index].name!=null?data.friends![index].name![0]:"0"),
                                    ):
                                    CircleAvatar(
                                      radius:50,
                                      backgroundImage:NetworkImage(data.friends![index].image!),
                                    )
                                ),
                                Expanded(
                                    flex: 8,
                                    child: Text(data.friends![index].name??"No Name",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),)
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child:InkWell(
                                onTap: (){
                                  Navigator.pushNamed(context, FRIEND_DETAILS,arguments: {
                                    "user":data.friends![index]
                                  });
                                },
                                child: Icon(Icons.arrow_forward_ios_outlined))
                        ),
                      ],
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

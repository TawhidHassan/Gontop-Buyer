import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gontop_buyer/Bloc/Friend/friend_cubit.dart';

import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../../Data/Model/User/User.dart';
import '../../../Service/LocalDataBase/localdata.dart';
import '../../Widgets/TextField/on_chnage_text_textdield2.dart';

class FindFriendPage extends StatefulWidget {
  const FindFriendPage({Key? key}) : super(key: key);

  @override
  _FindFriendPageState createState() => _FindFriendPageState();
}

class _FindFriendPageState extends State<FindFriendPage> {
  String? token;
  List<User>? dataLocal=[];
  List<User>? serachResult=[];
  //storage instance
  LocalDataGet _localDataGet = LocalDataGet();
  TextEditingController searchController= TextEditingController();
  getToken() async {
    var tokenx = await _localDataGet.getData();
    setState(() {
      token = tokenx.get('token');
      BlocProvider.of<FriendCubit>(context).getAllUser(token, "BUYER");
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
                  child: Text('Find Friend', style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, FRIEND_REQUEST_LIST);
                    },
                    child: Center(
                      child: Icon(Icons.person_add_alt,color: Colors.white,),
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              child: OnChangeTextField2(controller:searchController,hintText: "Enter user Name",lable: "Enter User Name",readOnly: false,tap: (String text){
                  setState(() {
                     serachResult= dataLocal!.where((element) => element.name==text).toList();
                  });
               },
              ),
            ),
            Expanded(
              child: BlocListener<FriendCubit, FriendState>(
                listener: (context, state) {
                  if(state is GetAllBuyerUsers){
                    final data=(state as GetAllBuyerUsers).userResponse;
                    dataLocal=data!.data;
                  }
                },
                child: BlocBuilder<FriendCubit, FriendState>(
                  builder: (context, state) {
                    if(state is !GetAllBuyerUsers){
                      return Center(child: CircularProgressIndicator(color: Colors.white,),);
                    }
                    final data=(state as GetAllBuyerUsers).userResponse;
                    return ListView.builder(
                        itemCount: serachResult!.length,
                        itemBuilder:(context,index){
                          return InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, USER_DETAILS,arguments: {
                                "user":serachResult![index]
                              });
                            },
                            child: Container(
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
                                      flex: 2,
                                      child:serachResult![index].image=="N/A"?CircleAvatar(
                                        radius:50,
                                        child: Text(serachResult![index].name!=null?serachResult![index].name![0]:"0"),
                                      ):
                                      CircleAvatar(
                                        radius:50,
                                        backgroundImage:NetworkImage(serachResult![index].image!),
                                      )
                                  ),
                                  Expanded(
                                      flex: 8,
                                      child: Text(serachResult![index].name??"No Name",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),)
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child:Icon(Icons.arrow_forward_ios_outlined)
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
            )
          ],
        ),
      ),
    );
  }
}

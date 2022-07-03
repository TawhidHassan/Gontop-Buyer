import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Bloc/Friend/friend_cubit.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../../Service/LocalDataBase/localdata.dart';

class FriendRequestList extends StatefulWidget {
  const FriendRequestList({Key? key}) : super(key: key);

  @override
  _FriendRequestListState createState() => _FriendRequestListState();
}

class _FriendRequestListState extends State<FriendRequestList> {
  String? token;

  //storage instance
  LocalDataGet _localDataGet = LocalDataGet();

  getToken() async {
    var tokenx = await _localDataGet.getData();
    setState(() {
      token = tokenx.get('token');
      BlocProvider.of<FriendCubit>(context).getAllRequstedUser(token);
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
                  child: Text('Requested User List', style: TextStyle(
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
            if(state is !GetAllRequestedUsers){
              return Center(child: CircularProgressIndicator(color: Colors.white,),);
            }
            final data=(state as GetAllRequestedUsers).requestedUserResponse;
            return ListView.builder(
                itemCount: data!.friends!.length,
                itemBuilder:(context,index){
                  return InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, USER_DETAILS_REQUESTED,arguments: {
                        "user":data.friends![index].userOne,
                        "id":data.friends![index].id
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
                              child:data.friends![index].userOne!.image=="N/A"?CircleAvatar(
                                radius:50,
                                child: Text(data.friends![index].userOne!.name!=null?data.friends![index].userOne!.name![0]:"0"),
                              ):
                              CircleAvatar(
                                radius:50,
                                backgroundImage:NetworkImage(data.friends![index].userOne!.image!),
                              )
                          ),
                          Expanded(
                              flex: 8,
                              child: Text(data.friends![index].userOne!.name??"No Name",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),)
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
    );
  }
}

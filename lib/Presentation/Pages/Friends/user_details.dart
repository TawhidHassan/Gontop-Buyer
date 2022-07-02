import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gontop_buyer/Bloc/Friend/friend_cubit.dart';

import '../../../Constants/Colors/app_colors.dart';
import '../../../Data/Model/User/User.dart';
import '../../../Service/LocalDataBase/localdata.dart';
import '../../Widgets/Button/custom_btn.dart';

class UserDetails extends StatefulWidget {
  final User? user;
  const UserDetails({Key? key, this.user}) : super(key: key);
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  String? token;
  bool? isLoading=false;
  //storage instance
  LocalDataGet _localDataGet = LocalDataGet();

  getToken() async {
    var tokenx = await _localDataGet.getData();
    setState(() {
      token = tokenx.get('token');

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
        elevation: 2,
        title: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Expanded(
                flex: 18,
                child: Center(
                  child: Text('User Details', style: TextStyle(
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
      body: BlocListener<FriendCubit, FriendState>(
        listener: (context, state) {
          if(state is AddrequestSent){
            setState(() {
              isLoading=false;
              showAlertDialog(context);
            });
          }
        },
        child: Container(
          margin: EdgeInsets.only(top: 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              widget.user!.image=="N/A"?CircleAvatar(
                backgroundColor: Colors.white,
                radius:30,
                child: Text(widget.user!.name!=null?widget.user!.name![0]:"0"),
              ):
              CircleAvatar(
                radius:50,
                backgroundImage:NetworkImage(widget.user!.image!),
              ),
              SizedBox(height: 10,),
              Text(widget.user!.name!,style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),),
              Text(widget.user!.email!,style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),),
              Text(widget.user!.phoneNumber!,style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              isLoading!?Center(child: CircularProgressIndicator(color: Colors.white,),): Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: CustomBtn(
                  btnText: 'Add Request',
                  onpressed: (){
                    setState(() {
                      isLoading=true;
                    });
                    BlocProvider.of<FriendCubit>(context).addRequest(token,widget.user!.id);
                  },
                ),
              ),
            ],

          ),
        ),
      ),
    );
  }


  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Container(
        height: 300,
        width: MediaQuery.of(context).size.width*0.7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/icons/check_grren.png'),
            const Text("Done!",style: TextStyle(color: Color(0XFF000000),fontSize:30,fontWeight: FontWeight.w800 ),textAlign: TextAlign.center,),
            const Text("You have successfully Send frieend request.",style: TextStyle(color: Color(0XFF000000),fontSize:16,fontWeight: FontWeight.w400 ),textAlign: TextAlign.center,),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child:  InkWell(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueAccent
                    ),
                    child: Text("Go Back",style: TextStyle(color: Color(0XFFffffff),fontSize:16 ),textAlign: TextAlign.center,),
                  ),
                )
            ),
          ],
        ),
      ),
    );
    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  
}

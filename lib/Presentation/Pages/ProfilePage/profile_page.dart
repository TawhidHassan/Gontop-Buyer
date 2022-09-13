import 'package:flutter/material.dart';

import '../../../Constants/Strings/app_strings.dart';
import '../../../Service/LocalDataBase/localdata.dart';
import '../../Widgets/Button/custom_btn.dart';
import '../Home/home_page.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? token;
  String? id;
  String? image;
  String? name;
  String? email;

  //storage instance
  LocalDataGet _localDataGet = LocalDataGet();

  getToken() async {
    var tokenx = await _localDataGet.getData();
    setState(() {
      token = tokenx.get('token');
      id = tokenx.get('userId');
      name = tokenx.get('name');
      email = tokenx.get('email');
      image = tokenx.get('image');
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
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(

        children: [

          SizedBox(height: 12,),
          Container(
            margin: EdgeInsets.only(right: 10),
            child: image=="N/A"? const CircleAvatar(
              radius: 35.0,
              backgroundImage:AssetImage("assets/images/bkash.png"),
              backgroundColor: Colors.transparent,
            ):CircleAvatar(
              radius: 35.0,
              backgroundImage: NetworkImage(image!),
              backgroundColor: Colors.transparent,
            ),
          ),
          SizedBox(height: 12,),
          Text(name??"",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
          Text(email!,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
          SizedBox(height: 12,),
          Row(
            children: [
              Expanded(
                child: CustomBtn(
                  color: Colors.greenAccent,
                  btnText: "Edit Profile",
                  onpressed: (){
                    Navigator.pushNamed(context, UODATE_PROFILE);
                  },
                ),
              ),
              SizedBox(width: 16,),
              Expanded(
                  child: CustomBtn(
                    color: Colors.orangeAccent,
                    btnText: "Password",
                    onpressed: (){
                      Navigator.pushNamed(context, NEW_PASSWORD_PAGE);
                    },
                  )
              )
            ],
          ),
          SizedBox(height: 16,),
          CustomBtn(
            color: Colors.redAccent,
            btnText: "Logout",
            onpressed: (){
              logOut(context);
            },
          )

        ],
      ),
    );
  }
}

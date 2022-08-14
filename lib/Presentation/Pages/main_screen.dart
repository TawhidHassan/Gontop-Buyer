import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../Constants/Colors/app_colors.dart';
import '../../Service/LocalDataBase/localdata.dart';
import 'Chat/seller_list.dart';
import 'ForgetPassword/new_password.dart';
import 'ForgetPassword/reset_password.dart';
import 'Friends/find_friend.dart';
import 'Home/home_page.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'ProfilePage/profile_page.dart';
class MainScreen extends StatefulWidget {
  final IO.Socket? socket;

  const MainScreen({Key? key, this.socket}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;
  final PageController _controller = PageController(initialPage: 0);


  String? token;
  String? userId;

  //storage instance
  LocalDataGet _localDataGet = LocalDataGet();

  getToken() async {
    var tokenx = await _localDataGet.getData();
    setState(() {
      userId = tokenx.get('userId');
      // Logger().d(token);
    });
    socketSetup();
  }
  socketSetup()async{
    // Logger().e("calling");
    widget.socket!.emit("setup", {"_id":userId});

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body:  SafeArea(
        child: PageView(
          controller: _controller,
          children:   <Widget>[
            HomePage(),
            FindFriendPage(),
            SellerListChat(),
            ProfilePage(),
          ],
          onPageChanged: (int index){
            setState(() {
              _pageIndex=index;
            });
          },
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xFF3879F0),
        unselectedItemColor: Colors.white,
        backgroundColor: Color(0xFF202358),
        type: BottomNavigationBarType.fixed,
        elevation: 1,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded ),
            label: 'Profile',
          ),
        ],
        currentIndex:_pageIndex,
        onTap: (int index){
          setState(() {
            _pageIndex = index;
            _controller.jumpToPage(index);
          },
          );
        },
      ),
    );
  }
}



import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../Constants/Colors/app_colors.dart';
import 'Friends/find_friend.dart';
import 'Home/home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;
  final PageController _controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body:  SafeArea(
        child: PageView(
          controller: _controller,
          children:  <Widget>[
            HomePage(),
            FindFriendPage(),
            HomePage(),
            HomePage(),
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
            icon: Icon(Icons.school),
            label: 'School',
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



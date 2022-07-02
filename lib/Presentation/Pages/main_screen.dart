import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../Constants/Colors/app_colors.dart';
import 'Home/home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:  SafeArea(
        child: IndexedStack(
          index: _pageIndex,
          children:  <Widget>[
            HomePage(),
            Container(
              color: Colors.blue,
              height: 300,
            ),
            HomePage(),
            HomePage(),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
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
          },
          );
        },
      ),
    );
  }
}



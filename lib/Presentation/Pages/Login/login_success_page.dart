
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../Screens/SplashScreen/splash_screen.dart';
import '../../Widgets/Button/custom_btn.dart';
import '../main_screen.dart';
class LoginSuccessPage extends StatelessWidget {
  const LoginSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 11,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/success.svg'),
                      const Text('Hi! Welcome Back',style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color:boldTextColor
                      ),),
                      const SizedBox(height: 8),
                      const Text('Nice to see you again. Let’s find your\nfavorite car!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color:lightTextColor
                        ),),
                    ],
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: CustomBtn(btnText: 'Go to Home',onpressed: (){
                      Navigator.pushReplacement(context, PageTransition(MainScreen()));
                    },),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

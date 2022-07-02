
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../Widgets/Button/custom_btn.dart';
class ForgetPasswordPage extends StatefulWidget {
  ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  bool isSelected = true;
  int? tapIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              margin: EdgeInsets.only(left: 16,right: 16,top: 112),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Forgot Password',style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color:boldTextColor
                    ),),
                    const SizedBox(height: 8),
                    Text('Select which contact details should we use\nto reset your password',style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color:lightTextColor
                    ),),
                    const SizedBox(height: 40),
                    InkWell(
                      onTap: (){
                        setState(() {
                          isSelected = false;
                          Navigator.pushNamed(context, RESET_PAGE);
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(17),
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: isSelected?unselectedBorderColor:selectedBorderColor,width: 1)
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset('assets/icons/Combined-Shape.svg',color: btnColor,),
                            const SizedBox(width: 17,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Email',style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: boldTextColor
                                ),),
                                Text('Enter your email, we will send you\nconfirmation code',style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: lightTextColor
                                ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, SEND_CODE);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(17),
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: btnColor,width: 1)
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset('assets/icons/Combined-Shape.svg',color: btnColor,),
                            const SizedBox(width: 17,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Phone',style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: boldTextColor
                                ),),
                                Text('Enter your phone number, we will send\nyou confirmation code',style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: lightTextColor
                                ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 236,),
                    CustomBtn(
                      btnText: 'Continue',
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}

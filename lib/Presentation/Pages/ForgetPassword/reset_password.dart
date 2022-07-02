
import 'package:flutter/material.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../Widgets/Button/custom_btn.dart';
import '../../Widgets/TextField/normal_textfield.dart';
class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController emilController= TextEditingController();
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
                    Text('Reset Password',style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color:boldTextColor
                    ),),
                    const SizedBox(height: 8),
                    Text('Enter your email, we will send you the\nconfirmation code',style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color:lightTextColor
                    ),),
                    const SizedBox(height: 40),
                    MaterialTextField(lable:"Email",readOnly: false,icon: Icon(Icons.email_outlined,color: Colors.black.withOpacity(0.3),), controller:emilController, hintText: 'Email' ,),
                    SizedBox(height: 153,),
                    CustomBtn(
                      btnText: 'Continue',
                      onpressed: (){
                        Navigator.pushNamed(context, RESEND_PAGE);
                      },
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

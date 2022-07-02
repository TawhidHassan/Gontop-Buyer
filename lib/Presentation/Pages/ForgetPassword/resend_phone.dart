
import 'package:flutter/material.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../Widgets/Button/custom_btn.dart';
class ResetPhonePage extends StatefulWidget {
  ResetPhonePage({Key? key}) : super(key: key);

  @override
  State<ResetPhonePage> createState() => _ResetPhonePageState();
}

class _ResetPhonePageState extends State<ResetPhonePage> {
  TextEditingController phoneController= TextEditingController();
  bool isSelected = true;
  int? tapIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: Padding(
                padding: const EdgeInsets.all(26.0),
                child: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back,color: Colors.black,),
                ),
              ),
            ),
            backgroundColor: Colors.white,
            body: Container(
              margin: EdgeInsets.only(left: 16,right: 16,top: 112),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Enter your phone number, we will send you\nthe confirmation code',style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color:lightTextColor
                    ),),
                    const SizedBox(height: 40),
                    SizedBox(height: 153,),
                    CustomBtn(
                      btnText: 'Send Code Number',
                      onpressed: (){
                        Navigator.pushNamed(context, OTP_PAGE);
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

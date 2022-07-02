
import 'package:flutter/material.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../Widgets/TextField/password_textfield.dart';
class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController newpasswordController= TextEditingController();
  TextEditingController confirmpasswordController= TextEditingController();
  final _globalkey = GlobalKey<FormState>();
  late String pasword;
  double _strength = 0;
  String _display = "password";

  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");

  bool _passwordVisible = true;

  @override
  void initState() {
    _passwordVisible = true;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        maintainBottomViewPadding: true,
        minimum: EdgeInsets.zero,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.5,
              toolbarHeight: 64,
              leading: BackButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                color: Colors.black,
              )
          ),
          resizeToAvoidBottomInset: false,
          body: Container(
            width: MediaQuery.of(context).size.width,
            child: Container(
              margin: EdgeInsets.only(left: 24,right:24,top: 120),
              child: Form(
                key: _globalkey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      const Text('Create New Password',style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color:boldTextColor
                      ),),
                      const SizedBox(height: 8),
                      const Text('Please enter the new password',style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color:lightTextColor
                      ),),
                      const SizedBox(height: 40),
                      const Text('New password',style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color:lightTextColor
                      ),),
                      const SizedBox(height: 12,),
                      //MaterialTextFieldPassword(lable: tr(""),controller:newpasswordController ,icon: Icon(Icons.vpn_key_outlined,color: Colors.black.withOpacity(0.3)), ),
                      Container(
                        height: 56,
                        child: TextFormField(
                          onChanged: (value)=> _checkPassword(value),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fillup';
                            }
                            return null;
                          },
                          obscureText: _passwordVisible,
                          controller: newpasswordController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.vpn_key_outlined,color: Colors.black.withOpacity(0.3)),
                            hintText: "",
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color:textFieldBorder,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color:textFieldBorder, width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: textFieldFocusBorder, width: 2.0),
                              borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            ),
                          ),
                        ),
                      ),


                      const SizedBox(height: 12,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 12,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 88,
                                  child: LinearProgressIndicator(
                                    value: _strength,
                                    backgroundColor: Color(0xFFE2E8F0),
                                    minHeight: 8,
                                    color: _strength<=1/4?Colors.red:null,
                                  ),
                                ),
                                const SizedBox(width: 8,),
                                Container(
                                  width: 88,
                                  child: LinearProgressIndicator(
                                    value: _strength,
                                    backgroundColor: Color(0xFFE2E8F0),
                                    minHeight: 8,
                                    color: _strength<=2/4?Colors.yellow:null,
                                  ),
                                ),
                                const SizedBox(width: 8,),
                                Container(
                                  width: 88,
                                  child: LinearProgressIndicator(
                                    value: _strength,
                                    backgroundColor: Color(0xFFE2E8F0),
                                    minHeight: 8,
                                    color: _strength<=3/4?Colors.green:null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20,),
                          Expanded(
                            flex: 3,
                            child: Text(_display,style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF94A3B8)
                            ),),
                          )
                        ],
                      ),
                      const SizedBox(height: 40,),
                      const Text('Confirm password',style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color:lightTextColor
                      ),),
                      const SizedBox(height: 12,),
                      MaterialTextFieldPassword(lable: "",controller:confirmpasswordController ,icon: Icon(Icons.vpn_key_outlined,color: Colors.black.withOpacity(0.3)), hintText: '', ),
                      const SizedBox(height: 12,),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _checkPassword(String value){
    pasword = value.trim();
    if(pasword.isEmpty){
      setState(() {
        _strength = 0;
        _display = "Enter password";
      });
    }else if(pasword.length<6){
      setState(() {
        _strength = 1/4;
        _display = "Too short";
      });
    }else if(pasword.length<8){
      setState(() {
        _strength = 2/4;
        _display = "Not strong";
      });
    } else{
      if(!letterReg.hasMatch(pasword) || !numReg.hasMatch(pasword)){
        _strength = 3/4;
        _display = "Strong";
      }else{
        setState(() {
          _strength = 1;
          _display = "Standard";
        });
      }
    }
  }
}


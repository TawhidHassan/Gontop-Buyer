import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gontop_buyer/Presentation/Pages/Home/home_page.dart';

import '../../../Bloc/Login/login_cubit.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Service/LocalDataBase/localdata.dart';
import '../../Widgets/Button/custom_btn.dart';
import '../../Widgets/TextField/password_textfield.dart';


class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({Key? key}) : super(key: key);

  @override
  _NewPasswordPageState createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  TextEditingController newpasswordController= TextEditingController();
  TextEditingController confirmpasswordController= TextEditingController();
  TextEditingController currentpasswordController= TextEditingController();
  final _globalkey = GlobalKey<FormState>();
  late String pasword;
  double _strength = 0;
  String _display = "password";

  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");

  bool _passwordVisible = true;
  String? token;
  bool isLoading = false;

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
    super.initState();
    _passwordVisible = true;
    getToken();
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if(state is LoginUser){
          final data=(state as LoginUser).login;
          if(data!.status=="success"){
            logOut(context);
          }else if(data.status=="fail"){
            setState(() {
              isLoading=false;
            });
            errorAlertDialog(context,data.message!);
          }else if(data.status=="error"){
            setState(() {
              isLoading=false;
            });
            errorAlertDialog(context,data.message!);
          }

        }
      },
      child: Container(
        color: kPrimaryColorx,
        child: SafeArea(
          maintainBottomViewPadding: true,
          minimum: EdgeInsets.zero,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                title: Text("Set New Password"),
                backgroundColor: kPrimaryColorx,
                elevation: 0.5,
                toolbarHeight: 64,
                leading: BackButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  color: Colors.white,
                )
            ),
            resizeToAvoidBottomInset: true,
            body: Container(
              width: MediaQuery.of(context).size.width,
              child: Container(
                margin: EdgeInsets.only(left: 16,right:16,top: 60),
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
                        const SizedBox(height: 40,),
                        const Text('Current password',style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color:lightTextColor
                        ),),
                        const SizedBox(height: 12,),
                        MaterialTextFieldPassword(lable: "",controller:currentpasswordController ,icon: Icon(Icons.vpn_key_outlined,color: Colors.black.withOpacity(0.3)), hintText: '', ),

                        const SizedBox(height: 40),
                        const Text('New password',style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color:lightTextColor
                        ),),
                        const SizedBox(height: 12,),
                        //MaterialTextFieldPassword(lable: tr(""),controller:newpasswordController ,icon: Icon(Icons.vpn_key_outlined,color: Colors.black.withOpacity(0.3)), ),
                        TextFormField(
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
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                              BorderSide(color:textFieldBorder, width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                              BorderSide(color: textFieldFocusBorder, width: 2.0),
                              borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: LinearProgressIndicator(
                                  value: _strength,
                                  backgroundColor: Color(0xFFE2E8F0),
                                  minHeight: 8,
                                  color: _strength<=1/4?Colors.red:null,
                                ),
                              ),
                              const SizedBox(width: 8,),
                              Expanded(
                                flex: 2,
                                child: LinearProgressIndicator(
                                  value: _strength,
                                  backgroundColor: Color(0xFFE2E8F0),
                                  minHeight: 8,
                                  color: _strength<=2/4?Colors.yellow:null,
                                ),
                              ),
                              const SizedBox(width: 8,),
                              Expanded(
                                flex: 2,
                                child: LinearProgressIndicator(
                                  value: _strength,
                                  backgroundColor: Color(0xFFE2E8F0),
                                  minHeight: 8,
                                  color: _strength<=3/4?Colors.green:null,
                                ),
                              ),
                              const SizedBox(width: 8,),
                              Expanded(
                                flex: 3,
                                child: Text(_display,style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF94A3B8)
                                ),),
                              ),
                            ],
                          ),
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

                        isLoading? Center(child: CircularProgressIndicator(),): CustomBtn(
                          color: Colors.greenAccent,
                          btnText: "Update Password",
                          onpressed: (){
                            if (_globalkey.currentState!.validate()) {
                              if(newpasswordController.text!=confirmpasswordController.text){
                                passwordNotmatchAlertDialog(context);
                              }else{
                                setState(() {
                                  isLoading = true;
                                });
                                BlocProvider.of<LoginCubit>(context).passWordChange(currentpasswordController.text,newpasswordController.text,confirmpasswordController.text,token!);
                              }
                            }
                          },
                        ),

                      ],
                    ),
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


passwordNotmatchAlertDialog(BuildContext context) {
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
          const Text("Warning!",style: TextStyle(color: Colors.orange,fontSize:30,fontWeight: FontWeight.w800 ),textAlign: TextAlign.center,),
          const Text("Your New Password and \n Confirm Password not match.",style: TextStyle(color: Color(0XFF000000),fontSize:16,fontWeight: FontWeight.w400 ),textAlign: TextAlign.center,),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child:  InkWell(
                onTap: (){
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
                  child: Text("Close",style: TextStyle(color: Color(0XFFffffff),fontSize:16 ),textAlign: TextAlign.center,),
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
errorAlertDialog(BuildContext context,String msg) {
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
          const Text("Warning!",style: TextStyle(color: Colors.orange,fontSize:30,fontWeight: FontWeight.w800 ),textAlign: TextAlign.center,),
          Text(msg,style: TextStyle(color: Color(0XFF000000),fontSize:16,fontWeight: FontWeight.w400 ),textAlign: TextAlign.center,),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child:  InkWell(
                onTap: (){
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
                  child: Text("Close",style: TextStyle(color: Color(0XFFffffff),fontSize:16 ),textAlign: TextAlign.center,),
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:progress_state_button/progress_button.dart';
import '../../../Bloc/Login/login_cubit.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../../Service/LoginService/save_user_data_local.dart';
import '../../../auth_server.dart';
import '../../Screens/SplashScreen/splash_screen.dart';
import '../../Widgets/Button/custom_google_btn.dart';
import '../../Widgets/TextField/normal_textfield.dart';
import '../../Widgets/TextField/password_textfield.dart';
import '../main_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  TextEditingController emilController= TextEditingController();
  TextEditingController passwordController= TextEditingController();
  final _globalkey = GlobalKey<FormState>();

  late bool circule;
  late bool validate;

  ButtonState progressButtonState = ButtonState.idle;

  //local dataBase
  Box? users;
  LoginDataSave? loginDataSave;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Logger().e( FirebaseAuth.instance.currentUser!);

    users =Hive.box('users');
    loginDataSave=LoginDataSave();

  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        // TODO: implement listener}
        if(state is LoginUser){
          setState(() {
            progressButtonState = ButtonState.idle;
          });

          final data=(state as LoginUser).login;

          if(data!.status=="fail"){
            // ignore: deprecated_member_use
            setState(() {
              isLoading=false;
            });
            print(data.status);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("User id and password are mismatched"),
              ),
            );
          }else{
            loginDataSave?.storeTokenUserdata(users,data.token, data.user!.id, data.user!.name, data.user!.email, data.user!.role,data.user!.image!,data.user!.phoneNumber);
            Navigator.pushReplacement(context, PageTransition(MainScreen()));
          }
        }
      },
      child: Container(
        color: Colors.white,
        child: SafeArea(
          maintainBottomViewPadding: true,
          minimum: EdgeInsets.zero,
          child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 24,right:24,top: 120),
                      child: Form(
                        key: _globalkey,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              const Text('Hi! Welcome Back',style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color:boldTextColor
                              ),),
                              const SizedBox(height: 8),
                              const Text('Signup to your account',style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color:lightTextColor
                              ),),
                              const SizedBox(height: 71),
                              MaterialTextField(hintText:"Email",readOnly: false,icon: Icon(Icons.email_outlined,color: Colors.black.withOpacity(0.3),), controller:emilController, lable: '' ,),
                              const SizedBox(height: 12,),
                              MaterialTextFieldPassword(hintText:"Password",controller:passwordController ,icon: Icon(Icons.vpn_key_outlined,color: Colors.black.withOpacity(0.3)), lable: 'password', ),
                              const SizedBox(height: 12,),
                              Align(
                                alignment:Alignment.bottomRight,
                                child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, FORGET_PASSWORD_PAGE);
                                    },
                                    child:  Text("Forget Password?",style: const TextStyle(color: btnColor,fontSize: 14,fontWeight: FontWeight.w500),)
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 56,
                                margin: EdgeInsets.only(top: 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: isLoading?btnProgressColor:btnColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: isLoading?
                                  CircularProgressIndicator(color: Colors.white):
                                  Text('Log In',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.white),),
                                  onPressed: () async {
                                    if (_globalkey.currentState!.validate()) {
                                      if (isLoading) return;
                                      setState(() {
                                        isLoading = true;
                                        BlocProvider.of<LoginCubit>(context).logIn(emilController.text,passwordController.text);
                                      });
                                    }


                                  },
                                ),
                              ),
                              SizedBox(height: 12,),
                              // InkWell(
                              //     onTap: (){
                              //       AuthService().signInWithGoogle();
                              //     },
                              //     child: Text("Google")),
                              // InkWell(
                              //     onTap: (){
                              //       AuthService().signOut();
                              //     },
                              //     child: Text("logOut")),
                              Align(
                                alignment:Alignment.bottomCenter,
                                child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, SIGNUP_PAGE);
                                    },
                                    child:  Text("Want To Create Account!",style: const TextStyle(color: btnColor,fontSize: 14,fontWeight: FontWeight.w500),)
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SvgPicture.asset("assets/images/Wave Art.svg"),
                    )
                  ],
                ),


            ),
          ),
        ),
      ),
    );
  }
}

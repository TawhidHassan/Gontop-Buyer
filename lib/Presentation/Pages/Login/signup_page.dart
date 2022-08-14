
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progress_state_button/progress_button.dart';
import '../../../Bloc/Login/login_cubit.dart';
import '../../../Bloc/User/user_cubit.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../../Service/LocalDataBase/localdata.dart';
import '../../../Service/LoginService/save_user_data_local.dart';
import '../../Screens/SplashScreen/splash_screen.dart';
import '../../Widgets/Button/custom_google_btn.dart';
import '../../Widgets/TextField/normal_textfield.dart';
import '../../Widgets/TextField/password_textfield.dart';
import '../main_screen.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLoading = false;
  TextEditingController emilController= TextEditingController();
  TextEditingController passwordController= TextEditingController();
  TextEditingController nameController= TextEditingController();
  TextEditingController phoneController= TextEditingController();
  final _globalkey = GlobalKey<FormState>();

  late bool circule;
  late bool validate;
  String? image;
  XFile? _image;
  final picker = ImagePicker();

  ButtonState progressButtonState = ButtonState.idle;
  bool circle=false;
  bool Categorycircle=false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  Future getImage() async{
    final imagesss=await picker.pickImage(source: ImageSource.camera);
    setState(() {
     _image=imagesss;
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        // TODO: implement listener
        if(state is LoginUser){
          setState(() {
            circle=false;
          });
         Navigator.pop(context);
        }
      },
      child: Container(
        color: Colors.white,
        child: SafeArea(
          maintainBottomViewPadding: true,
          minimum: EdgeInsets.zero,
          child: Scaffold(
            backgroundColor: Colors.white,
            body:  Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.all(12),
              child: Form(
                key: _globalkey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      InkWell(
                        onTap: (){
                          getImage();
                        },
                        child:_image==null? Container(
                          padding: EdgeInsets.all(20),
                          height: 126,
                          width: 126,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Color(0XFFF88A44).withOpacity(0.30)
                          ),
                          child: SvgPicture.asset("assets/icons/upload.svg"),
                        ):
                        Container(
                          height: 356,
                          width: MediaQuery.of(context).size.width,
                          child:Image.file(File(_image!.path),fit:BoxFit.cover,),
                        ),
                      ),
                      SizedBox(height: 20,),
                      MaterialTextField(hintText:"Name",readOnly: false,icon: Icon(Icons.stream,color: Colors.black.withOpacity(0.3),), controller:nameController, lable: '' ,),
                      SizedBox(height: 20,),
                      MaterialTextField(hintText:"Email",readOnly: false,icon: Icon(Icons.email_outlined,color: Colors.black.withOpacity(0.3),), controller:emilController, lable: '' ,),
                      const SizedBox(height: 12,),
                      MaterialTextField(hintText:"phone",readOnly: false,icon: Icon(Icons.stream,color: Colors.black.withOpacity(0.3),), controller:phoneController, lable: '' ,),
                      SizedBox(height: 12,),
                      MaterialTextFieldPassword(hintText:"Password",controller:passwordController ,icon: Icon(Icons.vpn_key_outlined,color: Colors.black.withOpacity(0.3)), lable: 'password', ),
                      const SizedBox(height: 12,),
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
                          child: circle?
                          CircularProgressIndicator(color: Colors.white):
                          Text('SignUp',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.white),),
                          onPressed: () async {
                            if (_globalkey.currentState!.validate()) {
                              setState(() {
                                circle=true;
                              });
                              BlocProvider.of<LoginCubit>(context).signUp(nameController.text,emilController.text,phoneController.text,passwordController.text,File(_image!.path));
                            }


                          },
                        ),
                      ),
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
}

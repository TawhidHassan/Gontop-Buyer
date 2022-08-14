
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gontop_buyer/Presentation/Pages/Home/home_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_state_button/progress_button.dart';
import '../../../Bloc/Login/login_cubit.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Service/LocalDataBase/localdata.dart';
import '../../Widgets/TextField/normal_textfield.dart';
import '../../Widgets/TextField/password_textfield.dart';

class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
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
  String? token;
  String? id;
  String? name;
  String? email;
  String? phone;


//storage instance
  LocalDataGet _localDataGet = LocalDataGet();

  getToken() async {
    var tokenx = await _localDataGet.getData();
    setState(() {
      token = tokenx.get('token');
      id = tokenx.get('userId');
      name = tokenx.get('name');
      email = tokenx.get('email');
      image = tokenx.get('image');
      phone = tokenx.get('phoneNumber');
      // Logger().d(token);
    });

    nameController.text=name!;
    emilController.text=email!;
    phoneController.text=phone!;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
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
        if(state is ProfileUpdated){
          setState(() {
            circle=false;
          });
         logOut(context);
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
              title: Text("Update Profile"),
            ),
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
                        child:image=="N/A"?  _image==null? Container(
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
                        ):CircleAvatar(
                          radius: 35.0,
                          backgroundImage: NetworkImage(image!),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      SizedBox(height: 20,),
                      MaterialTextField(hintText:"Name",readOnly: false,icon: Icon(Icons.stream,color: Colors.black.withOpacity(0.3),), controller:nameController, lable: '' ,),
                      SizedBox(height: 20,),
                      MaterialTextField(hintText:"Email",readOnly: false,icon: Icon(Icons.email_outlined,color: Colors.black.withOpacity(0.3),), controller:emilController, lable: '' ,),
                      const SizedBox(height: 12,),
                      MaterialTextField(hintText:"phone",readOnly: false,icon: Icon(Icons.stream,color: Colors.black.withOpacity(0.3),), controller:phoneController, lable: '' ,),
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
                              BlocProvider.of<LoginCubit>(context).updateProfile(token!,nameController.text,emilController.text,phoneController.text,passwordController.text,File(_image!.path),id!);
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

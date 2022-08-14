import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gontop_buyer/Bloc/User/user_cubit.dart';
import 'package:gontop_buyer/Constants/Colors/app_colors.dart';

import '../../../Bloc/Wallet/wallet_cubit.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../../Service/LocalDataBase/localdata.dart';
import '../../Screens/SplashScreen/splash_screen.dart';
import '../../Widgets/Button/custom_btn.dart';
import '../../Widgets/TextField/normal_backgroun_textfield.dart';
import '../../Widgets/TextField/normal_textfield.dart';
import '../main_screen.dart';

class PaymentRequestpage extends StatefulWidget {
  final String? methos;

  const PaymentRequestpage({Key? key, this.methos}) : super(key: key);

  @override
  _PaymentRequestpageState createState() => _PaymentRequestpageState();
}

class _PaymentRequestpageState extends State<PaymentRequestpage> {
  String? token;
  String? sellerId;
  String? userId;
  String? sellerphone;
  bool? isLoading=false;
  TextEditingController bisakhNumberController= TextEditingController();
  TextEditingController transactionController= TextEditingController();
  TextEditingController ammountController= TextEditingController();
  //storage instance
  LocalDataGet _localDataGet = LocalDataGet();
  final _globalkey = GlobalKey<FormState>();
  getToken() async {
    var tokenx = await _localDataGet.getData();
    setState(() {
      token = tokenx.get('token');
      userId = tokenx.get('userId');
      BlocProvider.of<UserCubit>(context).getRandomUser(token);
      // Logger().d(token);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: Text(widget.methos!),
      ),

      body: BlocListener<WalletCubit, WalletState>(
        listener: (context, state) {
         if(state is WalletRequestCreated){
           setState(() {
             isLoading=false;
             showAlertDialog(context);
           });
         }
        },
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height*0.8,
            child: BlocListener<UserCubit, UserState>(
              listener: (context, state) {
                if(state is GetRandomSeller){
                  final data=(state as GetRandomSeller).userResponse;
                  setState(() {
                    sellerId=data!.seller![0].id!;
                    sellerphone=data.seller![0].phoneNumber!;
                  });
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      if(state is !GetRandomSeller){
                        return Center(child: CircularProgressIndicator(color: Colors.white,),);
                      }
                      final data=(state as GetRandomSeller).userResponse;
                      return Expanded(
                        flex: 5,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Color(0xFFF3F3F3),
                              border: Border.all(color: Color(0xFFF88A44)),
                              borderRadius: BorderRadius.circular(12)
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Expanded(
                                  flex:1,
                                  child: Text("Send money to the given number \n and submit after filling the form \n with correct infromation",style: TextStyle(fontSize: 12,color: Color(0xFFF88A44)),textAlign: TextAlign.center,)
                              ),

                              Expanded(
                                  child: Container(
                                    width: 168,
                                      height: 51,
                                      decoration: BoxDecoration(
                                        borderRadius:BorderRadius.circular(8),
                                        border: Border.all(color: Color(0xFFF88A44)),
                                      ),
                                      child: Center(child: Text("${data!.seller![0].name}",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Color(0xFFF88A44)))))
                              ),
                              SizedBox(height: 20,),
                              Expanded(
                                  child: Container(
                                      width: 168,
                                      padding: EdgeInsets.all(8),
                                      height: 51,
                                      decoration: BoxDecoration(
                                        borderRadius:BorderRadius.circular(8),
                                        border: Border.all(color: Color(0xFFF88A44)),
                                      ),
                                      child: Center(
                                          child: Row(
                                            children: [
                                              Text("${data.seller![0].phoneNumber}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xFFF88A44))),
                                              InkWell(
                                                  onTap: (){
                                                    Clipboard.setData(ClipboardData(text: data.seller![0].phoneNumber));
                                                  },
                                                  child: Icon(Icons.copy,size: 18,))
                                            ],
                                          )
                                      )
                                  )
                              )
                            ],
                          ),

                        ),
                      );
                    },
                  ),
                  Expanded(
                      flex: 6,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Form(
                          key: _globalkey,
                          child: Column(
                            children: [
                              const SizedBox(height: 71),
                              MaterialTextFieldBackground(hintText:"Your bKash number ( sent from )",readOnly: false,icon: Icon(Icons.email_outlined,color: Colors.white.withOpacity(0.3),), controller:bisakhNumberController, lable: '' ,),
                              const SizedBox(height: 12,),
                              MaterialTextFieldBackground(hintText:"Transaction ID",readOnly: false,icon: Icon(Icons.videogame_asset_outlined,color: Colors.white.withOpacity(0.3),), controller:transactionController, lable: '' ,),
                              const SizedBox(height: 12,),
                              MaterialTextFieldBackground(hintText:"Amount",readOnly: false,icon: Icon(Icons.money,color: Colors.white.withOpacity(0.3),), controller:ammountController, lable: '' ,),
                              const SizedBox(height: 24,),

                            ],
                          ),
                        ),
                      )
                  ),
                  Expanded(
                    flex: 1,
                    child: isLoading!? Center(child: CircularProgressIndicator(color: Colors.white,),):Container(
                      margin: EdgeInsets.only(bottom: 10,left: 10,right: 10),
                      child: CustomBtn(
                        btnText: 'Continue',
                        onpressed: (){
                          if (_globalkey.currentState!.validate()) {
                            setState(() {
                              isLoading=true;
                            });
                            BlocProvider.of<WalletCubit>(context).createwalletRequest(token,widget.methos,sellerId,sellerphone,userId,bisakhNumberController.text,transactionController.text,ammountController.text);

                          }
                        },
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  showAlertDialog(BuildContext context) {
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
            Image.asset('assets/icons/check_grren.png'),
            const Text("Done!",style: TextStyle(color: Color(0XFF000000),fontSize:30,fontWeight: FontWeight.w800 ),textAlign: TextAlign.center,),
            const Text("You have successfully Send A request.",style: TextStyle(color: Color(0XFF000000),fontSize:16,fontWeight: FontWeight.w400 ),textAlign: TextAlign.center,),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child:  InkWell(
                  onTap: (){
                    Navigator.pushReplacement(context, PageTransition(MainScreen()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueAccent
                    ),
                    child: Text("Go Back home",style: TextStyle(color: Color(0XFFffffff),fontSize:16 ),textAlign: TextAlign.center,),
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
}

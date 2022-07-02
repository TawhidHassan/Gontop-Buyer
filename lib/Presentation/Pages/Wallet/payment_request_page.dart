import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gontop_buyer/Bloc/User/user_cubit.dart';
import 'package:gontop_buyer/Constants/Colors/app_colors.dart';

import '../../../Constants/Strings/app_strings.dart';
import '../../../Service/LocalDataBase/localdata.dart';
import '../../Widgets/Button/custom_btn.dart';
import '../../Widgets/TextField/normal_backgroun_textfield.dart';
import '../../Widgets/TextField/normal_textfield.dart';

class PaymentRequestpage extends StatefulWidget {
  final String? methos;

  const PaymentRequestpage({Key? key, this.methos}) : super(key: key);

  @override
  _PaymentRequestpageState createState() => _PaymentRequestpageState();
}

class _PaymentRequestpageState extends State<PaymentRequestpage> {
  String? token;
  TextEditingController bisakhNumberController= TextEditingController();
  TextEditingController transactionController= TextEditingController();
  TextEditingController ammountController= TextEditingController();
  //storage instance
  LocalDataGet _localDataGet = LocalDataGet();

  getToken() async {
    var tokenx = await _localDataGet.getData();
    setState(() {
      token = tokenx.get('token');
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

      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if(state is !GetRandomSeller){
                  return Center(child: CircularProgressIndicator(color: Colors.white,),);
                }
                final data=(state as GetRandomSeller).userResponse;
                return Expanded(
                  flex: 4,
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
                            flex:2,
                            child: Text("Send money to the given number \n and submit after filling the form \n with correct infromation",style: TextStyle(fontSize: 16,color: Color(0xFFF88A44)),textAlign: TextAlign.center,)
                        ),
                        Expanded(
                          flex: 2,
                            child: CircleAvatar(
                              radius:50,
                              backgroundImage:NetworkImage(data!.seller![0].image!),
                            )
                        ),
                        Expanded(
                            child: Text("${data.seller![0].name}",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Color(0xFFF88A44)))
                        ),
                        Expanded(
                            child: Text("${data.seller![0].phoneNumber}",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Color(0xFFF88A44)))
                        )
                      ],
                    ),

                  ),
                );
              },
            ),
            Expanded(
              flex: 5,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
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
                )
            ),
            Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(bottom: 10,left: 10,right: 10),
                  child: CustomBtn(
                    btnText: 'Continue',
                    onpressed: (){
                      Navigator.pushNamed(context, PAYMENT_REQUEST_PAGE);

                    },
                  ),
                ),
            )

          ],
        ),
      ),
    );
  }
}

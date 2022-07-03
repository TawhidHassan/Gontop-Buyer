import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Bloc/FundTransfer/fund_transfer_cubit.dart';
import '../../../Constants/Colors/app_colors.dart';
import '../../../Data/Model/User/User.dart';
import '../../../Service/LocalDataBase/localdata.dart';
import '../../Widgets/Button/custom_btn.dart';
import '../../Widgets/TextField/normal_backgroun_textfield.dart';

class SendFundPage extends StatefulWidget {
  final User? user;
  const SendFundPage({Key? key, this.user}) : super(key: key);

  @override
  _SendFundPageState createState() => _SendFundPageState();
}

class _SendFundPageState extends State<SendFundPage> {
  bool? isLoading=false;
  TextEditingController ammountController= TextEditingController();
  TextEditingController messageController= TextEditingController();
  String? token;
  String? userId;
  final _globalkey = GlobalKey<FormState>();
  LocalDataGet _localDataGet = LocalDataGet();
  getToken() async {
    var tokenx = await _localDataGet.getData();
    setState(() {
      token = tokenx.get('token');
      userId = tokenx.get('userId');
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
      backgroundColor: kPrimaryColorx,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColorx,
        elevation: 1,
        title: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back,color: Colors.white,)
                  )),
              const Expanded(
                flex: 18,
                child: Center(
                  child: Text('Transfer Money', style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),),
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocListener<FundTransferCubit, FundTransferState>(
        listener: (context, state) {
          if(state is FundTransferDone){
            setState(() {
              isLoading=false;
              showAlertDialog(context);
            });
          }
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.all(12),
                decoration:  BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color:Color(0xFFF88A44))
                ),
                child: Form(
                  key: _globalkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.user!.name!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0xFFF88A44)),),
                      const SizedBox(height: 12),
                      MaterialTextFieldBackground(hintText:"Enter Amount",
                        readOnly: false,
                        icon: const Icon(Icons.attach_money,
                          color: Colors.black,),
                        controller:ammountController,
                        lable: '' ,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 12,),
                      MaterialTextFieldBackground(hintText:"Your message",
                        readOnly: false,
                        icon: const Icon(Icons.chat,
                          color: Colors.black,),
                        controller:messageController,
                        lable: '' ,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              isLoading!?Center(child: CircularProgressIndicator(color: Colors.white,),): Container(
                margin: EdgeInsets.all(16),
                child: CustomBtn(
                  color: Colors.greenAccent,
                  btnText: 'Transfer',
                  onpressed: (){
                    if (_globalkey.currentState!.validate()) {
                      setState(() {
                        isLoading=true;
                      });
                      BlocProvider.of<FundTransferCubit>(context).unfriend(token,userId,widget.user!.id,ammountController.text,messageController.text);
                    }

                  },
                ),
              ),
            ],
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
            const Text("You have successfully Transfer your Fund.",style: TextStyle(color: Color(0XFF000000),fontSize:16,fontWeight: FontWeight.w400 ),textAlign: TextAlign.center,),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child:  InkWell(
                  onTap: (){
                    Navigator.pop(context);
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
                    child: Text("Go Back",style: TextStyle(color: Color(0XFFffffff),fontSize:16 ),textAlign: TextAlign.center,),
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

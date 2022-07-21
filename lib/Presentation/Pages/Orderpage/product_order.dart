import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gontop_buyer/Bloc/Order/order_cubit.dart';

import '../../../Bloc/Wallet/wallet_cubit.dart';
import '../../../Data/Model/Product/Product.dart';
import '../../../Service/LocalDataBase/localdata.dart';
import '../../Screens/SplashScreen/splash_screen.dart';
import '../../Widgets/Button/custom_btn.dart';
import '../../Widgets/TextField/normal_textfield.dart';
import '../main_screen.dart';

class OrderPage extends StatefulWidget {
  final String? id;
  final Product? product;
  const OrderPage({Key? key, this.id, this.product}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  TextEditingController ignController= TextEditingController();
  TextEditingController inGameNamweController= TextEditingController();
  TextEditingController fbMail= TextEditingController();
  TextEditingController fbPass= TextEditingController();
  bool? isLoading=false;
  String? token;
  String? sellerId;
  String? userId;
  final _globalkey = GlobalKey<FormState>();
  final LocalDataGet _localDataGet = LocalDataGet();
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
    return BlocListener<OrderCubit, OrderState>(
      listener: (context, state) {
        // TODO: implement listener
        if(state is OrderCreated){
          setState(() {
            isLoading=false;
            showAlertDialog(context);
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Create Order"),
              BlocBuilder<WalletCubit, WalletState>(
                builder: (context, state) {
                  if(state is !WalletUser){
                    return Center(child: CircularProgressIndicator(color: Colors.blueAccent,),);
                  }
                  final data=(state as WalletUser).walletResponse;
                  return InkWell(
                    onTap: (){

                    },
                    child: Container(
                      height: 30,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xFFF88A44)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset("assets/icons/shoppingcart.svg"),
                          Text("My Gontop Balance ("+data!.userwallet!.currentbalance!.toString()+"Tk)",style: const TextStyle(
                            fontSize: 14,fontWeight: FontWeight.w600,
                          ),),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.symmetric(vertical: 4),
                color: Color(0xffEDF5FF),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    widget.product!.image!="N/A"?
                    Expanded(
                      flex: 2,
                      child: CircleAvatar(
                        radius: 20.0,
                        backgroundImage:
                        NetworkImage( widget.product!.image!),
                        backgroundColor: Colors.transparent,
                      ),
                    ):const Expanded(
                      flex: 2,
                      child: CircleAvatar(
                        radius: 20.0,
                        backgroundImage:
                        AssetImage("assets/images/bkash.png"),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text( widget.product!.productName!+"("),
                              Text( widget.product!.points!.toString()+")"),
                            ],
                          ),
                          Text( widget.product!.price!.toString()+" Tk")
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color:  Color(0xffEDF5FF),
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _globalkey,
                  child: Column(
                    children: [
                      const SizedBox(height: 71),
                      MaterialTextField(hintText:"IGN",readOnly: false,icon: Icon(Icons.airline_seat_individual_suite_rounded,color: Colors.black.withOpacity(0.3),), controller:ignController, lable: '' ,),
                      const SizedBox(height: 12,),
                      MaterialTextField(hintText:"In Game Name",readOnly: false,icon: Icon(Icons.airline_seat_individual_suite_rounded,color: Colors.black.withOpacity(0.3),), controller:inGameNamweController, lable: '' ,),
                      const SizedBox(height: 12,),
                    ],
                  ),
                ),
              ),
              isLoading!? Center(child: CircularProgressIndicator(color: Colors.blueAccent,),):Container(
                margin: EdgeInsets.only(bottom: 10,left: 10,right: 10),
                child: CustomBtn(
                  btnText: 'Continue',
                  onpressed: (){
                    if (_globalkey.currentState!.validate()) {
                      setState(() {
                        isLoading=true;
                      });
                      BlocProvider.of<OrderCubit>(context).createOrder(token,widget.product!.id!,widget.product!.price!,widget.product!.game!,ignController.text,inGameNamweController.text,fbMail.text,fbPass.text);

                    }
                  },
                ),
              )
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
            const Text("You have successfully Send A Order request.",style: TextStyle(color: Color(0XFF000000),fontSize:16,fontWeight: FontWeight.w400 ),textAlign: TextAlign.center,),
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

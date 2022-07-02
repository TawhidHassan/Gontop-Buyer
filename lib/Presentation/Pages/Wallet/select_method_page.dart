import 'package:flutter/material.dart';


import '../../../Constants/Colors/app_colors.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../Widgets/Button/custom_btn.dart';
import '../../Widgets/Card/PaymentCard/paymentCard.dart';
class PaymentmethodPage extends StatefulWidget {
  const PaymentmethodPage({Key? key}) : super(key: key);

  @override
  _PaymentmethodPageState createState() => _PaymentmethodPageState();
}

class _PaymentmethodPageState extends State<PaymentmethodPage> {
  String? select;
  @override
  Widget build(BuildContext context) {
    return Container(
      color:kPrimaryColorx,
      child: SafeArea(
          child: Scaffold(
            backgroundColor: kPrimaryColorx,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColorx,
              elevation: 1,
              title: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                        child: Text('Payment Method',style: TextStyle(
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
            body:Container(
              margin: EdgeInsets.all(25),
              child: Column(
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        PaymentMethodCard(
                          PaymentImage: Image.asset('assets/images/bkash.png',),
                          PaymentName: 'Bkash',
                          userCode: '',
                          onPressed: (){
                            if(select!=null){
                              setState(() {
                                select=null;
                                select="Bkash";
                              });
                            }else{
                              setState(() {
                                select=null;
                                select="Bkash";
                              });
                            }
                            print(select);
                          }, 
                          borderColor:select=="Bkash"?Colors.white: kPrimaryColor,
                          color: select=="Bkash"?kPrimaryColor:Colors.white,
                        ),
                        PaymentMethodCard(
                          PaymentImage: Image.asset('assets/images/nagad.png',),
                          PaymentName: 'Nagad',
                          userCode: '',
                          borderColor:select=="Nagad"?Colors.white:kPrimaryColor,
                          color:select=="Nagad"?kPrimaryColor: Colors.white,
                          onPressed: (){
                            if(select!=null){
                              setState(() {
                                select=null;
                                select="Nagad";
                              });
                            }else{
                              setState(() {
                                select=null;
                                select="Nagad";
                              });
                            }
                            print(select);
                          },
                        ),

                      ],
                    ),
                  ),
                  CustomBtn(
                    btnText: 'Continue',
                    onpressed: (){
                      if(select!=null){
                        Navigator.pushNamed(context, PAYMENT_REQUEST_PAGE,arguments: {
                          "method":select
                        });
                      }

                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
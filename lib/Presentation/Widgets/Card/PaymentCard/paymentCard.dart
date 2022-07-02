
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../Constants/Colors/app_colors.dart';

class PaymentMethodCard extends StatefulWidget {
  final Image? PaymentImage;
  final String? PaymentName;
  final String? userCode;
  final VoidCallback? onPressed;
  final Color color;
  final Color borderColor;
  const PaymentMethodCard({
    this.PaymentImage, this.PaymentName, this.userCode,this.onPressed,
    Key? key, required this.color, required this.borderColor}) : super(key: key);

  @override
  State<PaymentMethodCard> createState() => _PaymentMethodCardState();
}

class _PaymentMethodCardState extends State<PaymentMethodCard> {
  int _value = 1;
  int _counter = 1;
  void _increment(){
    setState(() {
      _counter++;
    });
  }
  void _decrement(){
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.color,
          border: Border.all(color:widget.borderColor,width: 1),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFBBBBBB).withOpacity(0.2),
              spreadRadius: 4,
              blurRadius: 7,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.transparent,
                  child: Center(child: widget.PaymentImage)),
            ),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${widget.PaymentName}',style:  TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: widget.borderColor
                  ),),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


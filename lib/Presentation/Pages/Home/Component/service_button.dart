import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ServiceButton extends StatelessWidget {
  final String? title;
  final String? assets;
  const ServiceButton({Key? key, this.title, this.assets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(horizontal: 14,vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xff3A3A3A),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(assets!),
          SizedBox(height: 10,),
          Text(title!,style: TextStyle(color: Colors.white),)
        ],
      ),
    );
  }
}

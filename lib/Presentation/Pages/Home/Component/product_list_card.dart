import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeButton extends StatelessWidget {
  final String? image;
  final String? title;
  final Color? color;
  final Color? color2;
  const HomeButton({Key? key, this.image, this.title, this.color, this.color2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 9,horizontal: 9),
      height: 80,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(image!,color: color2,),
             Text(title!,style:  const TextStyle(
                fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black
            ))
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gontop_buyer/Data/Model/Slider/Sliders.dart';
import 'Slider.dart';
class SliderItem extends StatefulWidget {
  final int? intemIndex;
  final List<Sliders>? data;
  final String? title;
  final String? image;
  const SliderItem({Key? key, this.intemIndex, this.title, this.image, this.data}) : super(key: key);

  @override
  _SliderItemState createState() => _SliderItemState();
}

class _SliderItemState extends State<SliderItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: 151,
              margin: EdgeInsets.symmetric(horizontal: 14.0),
              padding: EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                  color: Color(0xFF4A86F4),
                  image: DecorationImage(
                    image: NetworkImage(widget.image!),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12)
              ),
              child:  Align(
                alignment: Alignment.centerLeft,
                child: Text(widget.title!, style: TextStyle(fontSize: 21.0,color: Colors.white),),
              )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.data!.map((image) {
              int index=widget.data!.indexOf(image);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.intemIndex == index
                        ? Color(0xFF3879F0)
                        : Colors.white
                ),
              );
            },
            ).toList(), // this was the part the I had to add
          ),
        ],
      ),
    );
  }
}

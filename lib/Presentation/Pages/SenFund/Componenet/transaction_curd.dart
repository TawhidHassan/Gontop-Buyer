import 'package:flutter/material.dart';

class DepositeCardItem extends StatelessWidget {
  final String? name;
  final String? image;
  final String? date;
  final String? ammount;
  final String? numberSend;
  final String? submitnumber;
  final String? methos;
  final String? status;
  const DepositeCardItem({Key? key, this.name, this.image, this.date, this.ammount, this.status, this.numberSend, this.submitnumber, this.methos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(vertical: 12,horizontal: 10),
      decoration: BoxDecoration(
          color:status=="accept"?Colors.greenAccent.shade100.withOpacity(0.5): Colors.orange.shade100.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12)
      ),
      margin: EdgeInsets.symmetric(vertical: 6,horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(image!,height: 32,width: 32,),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Text(name??"",style: TextStyle(fontSize:14,fontWeight: FontWeight.bold ),),
                  Text("Method: "+methos!,style: TextStyle(fontSize:11,fontWeight: FontWeight.bold ),),
                  Text("Receiver Number: "+numberSend!,style: TextStyle(fontSize:11,fontWeight: FontWeight.bold ),),
                  Text("Transaction Number: "+submitnumber!,style: TextStyle(fontSize:11,fontWeight: FontWeight.bold ),),
                  status!=null? Text(status=="accept"?"Accept":"Pending",style: TextStyle(fontSize:14,fontWeight: FontWeight.bold ),):Container(),
                  Text(date!,style: TextStyle(fontSize:9,fontWeight: FontWeight.bold,color: Color(0xFF868894) ),),
                ],
              ),
            ],
          ),
          Text(ammount!+"TK",style: TextStyle(fontSize:14,fontWeight: FontWeight.bold ),),
        ],
      ),
    );
  }
}

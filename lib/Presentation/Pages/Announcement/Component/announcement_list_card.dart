import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Bloc/Announcement/announcement_cubit.dart';
import '../../../../Service/LocalDataBase/localdata.dart';
import '../../../Screens/SplashScreen/splash_screen.dart';
import '../../main_screen.dart';

class announcementCard extends StatefulWidget {

  final String? title;
  final String? id;
  final num? likCount;
  final bool? isLike;

  const announcementCard({Key? key, this.title, this.id, this.likCount, this.isLike}) : super(key: key);

  @override
  State<announcementCard> createState() => _announcementCardState();
}

class _announcementCardState extends State<announcementCard> {

  TextEditingController nameController= TextEditingController();
  final _globalkey = GlobalKey<FormState>();
  bool circle=false;
  bool Categorycircle=false;
  String? token;
  num? incremnet=0;
  //storage instance
  LocalDataGet _localDataGet= LocalDataGet();
  getToken()async{
    var tokenx=await _localDataGet.getData();
    setState(() {
      token=tokenx.get('token');
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
    return BlocListener<AnnouncementCubit, AnnouncementState>(
      listener: (context, state) {
        if(state is AnnouncementCreate){
          setState(() {
            circle=false;
          });
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12 ),
            color: Color(0xFFEDF5FF)
        ),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 12,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title!,style: TextStyle(fontSize:16,fontWeight: FontWeight.bold ),),
                ],
              ),
              SizedBox(height: 12,),
              Row(
                children: [
                  circle?Center(child: CircularProgressIndicator(),):
                  InkWell(
                      onTap:(){
                        if(!widget.isLike!){
                          setState(() {
                            incremnet=1;
                          });
                          BlocProvider.of<AnnouncementCubit>(context).incrementLike(token,widget.id!);
                        }

                      },
                      child: Icon(Icons.thumb_up,color:widget.isLike!? Colors.green:Colors.grey,)
                  ),
                  Text(widget.likCount!=null?'${widget.likCount}':incremnet!.toString())
                ],
              )

            ],
          ),
        ),
      ),
    );
  }

}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gontop_buyer/Constants/Colors/app_colors.dart';

import '../../../Bloc/Announcement/announcement_cubit.dart';
import '../../../Constants/Strings/app_strings.dart';
import '../../../Service/LocalDataBase/localdata.dart';
import '../../Widgets/Button/custom_btn.dart';
import '../Home/home_page.dart';
import 'Component/announcement_list_card.dart';


class AnnouncemnetPage extends StatefulWidget {
  const AnnouncemnetPage({Key? key}) : super(key: key);
  @override
  _AnnouncemnetPageState createState() => _AnnouncemnetPageState();
}

class _AnnouncemnetPageState extends State<AnnouncemnetPage> {

  String? token;

  //storage instance
  LocalDataGet _localDataGet = LocalDataGet();

  getToken() async {
    var tokenx = await _localDataGet.getData();
    setState(() {
      token = tokenx.get('token');
      BlocProvider.of<AnnouncementCubit>(context).getAllAnnouncement(token);
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
        backgroundColor: kPrimaryColorx,
        title: const Text("Announcement", style: TextStyle(color: Colors.white),),
        leading: BackButton(color: kPrimaryColorx,),
      ),
      body: RefreshIndicator(
        onRefresh: refreshList,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 12,),
              Expanded(
                child: BlocBuilder<AnnouncementCubit, AnnouncementState>(
                  builder: (context, state) {
                    if(state is !GetAllAnnouncement){
                      return Center(child: CircularProgressIndicator(),);
                    }
                    final data=(state as GetAllAnnouncement).announcementResponse;
                    return ListView.builder(
                        itemCount: data!.announcement!.length,
                        itemBuilder: (context, index) {
                          return announcementCard(title: data.announcement![index].announcementText,id: data.announcement![index].id,isLike: data.announcement![index].userliked,likCount: data.announcement![index].likeCount,);
                        });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Null>refreshList() async{
    setState(() {
      BlocProvider.of<AnnouncementCubit>(context).getAllAnnouncement(token);
    });
    await Future.delayed(const Duration(seconds: 1));

  }
}

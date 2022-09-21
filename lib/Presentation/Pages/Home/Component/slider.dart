import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gontop_buyer/Presentation/Pages/Home/Component/slider_item.dart';

import '../../../../Bloc/Slider/slider_cubit.dart';
import '../../../../Bloc/Wallet/wallet_cubit.dart';
import '../../../../Constants/Strings/app_strings.dart';
import '../../../../Service/LocalDataBase/localdata.dart';

class SliderComponenet extends StatefulWidget {
  @override
  _SliderComponenetState createState() => _SliderComponenetState();
}

class _SliderComponenetState extends State<SliderComponenet> {
  String? token;

  //storage instance
  LocalDataGet _localDataGet = LocalDataGet();

  getToken() async {
    var tokenx = await _localDataGet.getData();
    token = tokenx.get('token');
    BlocProvider.of<SliderCubit>(context).getAllSliders(token);
    // Logger().d(token);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        BlocBuilder<SliderCubit, SliderState>(
          builder: (context, state) {
            if(state is !GetAllSlider){
              return const Center(child: CircularProgressIndicator(color: Colors.white,),);
            }
            final data=(state as GetAllSlider).sliderResponse;
            return data!.data==null||data.data!.isEmpty?Container(
              height: 200.0,
              color: Color(0xff3A3A3A),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Image.asset("assets/images/logo.png",height: 40,),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: const Text("Welcome back \n On Gontop",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                  )
                ],
              ),
            ):
            CarouselSlider.builder(
              itemCount: data.data!.length,
              itemBuilder:  (BuildContext context, int itemIndex, int pageViewIndex) =>
                  SliderItem(title: data.data![itemIndex].adsName,image: data.data![itemIndex].image,intemIndex: itemIndex,data: data.data),
              options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  enableInfiniteScroll: true,
                viewportFraction: 10,
              ),
            );
          },
        ),
        Positioned(
          top: 100,
          child: BlocBuilder<WalletCubit, WalletState>(
            builder: (context, state) {
              if(state is !WalletUser){
                return Center(child: CircularProgressIndicator(),);
              }
              final data=(state as WalletUser).walletResponse;
              return data!.userwallet!=null? InkWell(
                onTap: (){
                  Navigator.pushNamed(context, FUND_ADD_HISTORY_PAGE);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width*0.9,
                  height: 90,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFF0C0C0C)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("My Gontop Balance",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white),),
                          Row(
                            children: [
                              SvgPicture.asset("assets/icons/shoppingcart.svg"),
                              Text(data.userwallet!.currentbalance!.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white),),
                            ],
                          )
                        ],
                      ),
                      Divider(color: Colors.white,),
                      Text("My Wallet History >",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.white),),
                    ],
                  ),
                ),
              ):Container();
            },
          ),
        ),
      ],
    );
  }
}

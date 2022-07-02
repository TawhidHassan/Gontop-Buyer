import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gontop_buyer/Presentation/Pages/Home/Component/slider_item.dart';

import '../../../../Bloc/Slider/slider_cubit.dart';
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
    return BlocBuilder<SliderCubit, SliderState>(
      builder: (context, state) {
        if(state is !GetAllSlider){
          return const Center(child: CircularProgressIndicator(color: Colors.white,),);
        }
        final data=(state as GetAllSlider).sliderResponse;
        return data!.data==null||data.data!.isEmpty?Container(): 
        CarouselSlider.builder(
          itemCount: data.data!.length,
          itemBuilder:  (BuildContext context, int itemIndex, int pageViewIndex) =>
          SliderItem(title: data.data![itemIndex].adsName,image: data.data![itemIndex].image,intemIndex: itemIndex,data: data.data),
          options: CarouselOptions(
              height: 200.0,
            autoPlay: true,
            enableInfiniteScroll: true
          ),
        );
      },
    );
  }
}

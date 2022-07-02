
import 'dart:io';
import 'package:logger/logger.dart';

import '../../Data/Model/Slider/SliderResponse.dart';
import '../../Network/SliderNetworkService/slider_network.dart';

class SliderRepository{
  var logger = Logger();
  SliderNetwork sliderNetwork=SliderNetwork();




  Future<SliderResponse> getAllSliders(String? token) async{
    final userRaw=await sliderNetwork.getAllSliders(token);
    // logger.d(Login.fromJson(userRaw));

    return SliderResponse.fromJson(userRaw);
  }



}
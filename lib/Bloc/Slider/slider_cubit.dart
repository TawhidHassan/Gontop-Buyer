import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

import '../../Data/Model/Slider/SliderResponse.dart';
import '../../Data/Model/Supply/AdminSupply.dart';
import '../../Repository/SliderRepository/slider_repository.dart';
import '../../Repository/Supply/supply_repository.dart';

part 'slider_state.dart';

class SliderCubit extends Cubit<SliderState> with HydratedMixin{
  SliderRepository sliderRepository=SliderRepository();

  SliderCubit() : super(SliderInitial());


  void getAllSliders(String? token) {
    sliderRepository.getAllSliders(token).then((value) => {
      if(value !=null){
        emit(GetAllSlider(sliderResponse: value))
      }
    });
  }

  @override
  SliderState? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return GetAllSlider.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(SliderState state) {
    // TODO: implement toJson
    if (state is GetAllSlider) {
      return state.toMap();
    } else {
      return null;
    }
  }

}

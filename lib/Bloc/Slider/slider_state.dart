part of 'slider_cubit.dart';

@immutable
abstract class SliderState {}

class SliderInitial extends SliderState {}
class SliderCreated extends SliderState {}

class GetAllSlider extends SliderState {
  final SliderResponse? sliderResponse;

  GetAllSlider({this.sliderResponse});

  Map<String, dynamic> toMap() {
    return {
      'sliderResponse': this.sliderResponse,
    };
  }

  factory GetAllSlider.fromMap(Map<String, dynamic> map) {
    return GetAllSlider(
      sliderResponse:   map['sliderResponse'] == null
          ? null
          : SliderResponse.fromJson(
          map['sliderResponse'] as Map<String, dynamic>),
    );
  }
}


class GetAdminTotalSupplyValue extends SliderState {
  final AdminSupply? adminSupply;

  GetAdminTotalSupplyValue({this.adminSupply});

  Map<String, dynamic> toMap() {
    return {
      'adminSupply': this.adminSupply,
    };
  }

  factory GetAdminTotalSupplyValue.fromMap(Map<String, dynamic> map) {
    return GetAdminTotalSupplyValue(
      adminSupply:  map['adminSupply'] == null
          ? null
          : AdminSupply.fromJson(
          map['campingPlayListResponse'] as Map<String, dynamic>)
    );
  }
}
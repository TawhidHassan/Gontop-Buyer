// ignore_for_file: file_names


import 'package:gontop_buyer/Data/Model/AddFund/Fund.dart';
import 'package:gontop_buyer/Data/Model/User/User.dart';
import 'package:json_annotation/json_annotation.dart';


part 'FundResponse.g.dart';

@JsonSerializable()
class FundResponse{


      String? status;
      List<Fund>? depositamount;


      FundResponse(this.status, this.depositamount);

  factory FundResponse.fromJson(Map<String,dynamic>json)=>
          _$FundResponseFromJson(json);
      Map<String,dynamic>toJson()=>_$FundResponseToJson(this);
}
// ignore_for_file: file_names


import 'package:gontop_buyer/Data/Model/AddFund/Fund.dart';
import 'package:gontop_buyer/Data/Model/FunrdTransfer/FundTransfer.dart';
import 'package:gontop_buyer/Data/Model/User/User.dart';
import 'package:json_annotation/json_annotation.dart';


part 'FundTransferResponse.g.dart';

@JsonSerializable()
class FundTransferResponse{


      String? status;
      List<FundTransfer>? transferamount;


      FundTransferResponse(this.status, this.transferamount);

  factory FundTransferResponse.fromJson(Map<String,dynamic>json)=>
          _$FundTransferResponseFromJson(json);
      Map<String,dynamic>toJson()=>_$FundTransferResponseToJson(this);
}
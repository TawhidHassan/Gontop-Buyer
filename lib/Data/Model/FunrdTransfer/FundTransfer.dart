// ignore_for_file: file_names


import 'package:gontop_buyer/Data/Model/User/User.dart';
import 'package:json_annotation/json_annotation.dart';


part 'FundTransfer.g.dart';

@JsonSerializable()
class FundTransfer{

      @JsonKey(name: "_id")
      String? id;
      String? message;
      String? createdAt;
      num? transferamount;
      User? transferfrom;


      FundTransfer(this.id, this.message, this.createdAt, this.transferamount,
      this.transferfrom);

      factory FundTransfer.fromJson(Map<String,dynamic>json)=>
          _$FundTransferFromJson(json);
      Map<String,dynamic>toJson()=>_$FundTransferToJson(this);
}
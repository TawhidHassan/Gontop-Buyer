// ignore_for_file: file_names


import 'package:gontop_buyer/Data/Model/User/User.dart';
import 'package:json_annotation/json_annotation.dart';


part 'Fund.g.dart';

@JsonSerializable()
class Fund{

      @JsonKey(name: "_id")
      String? id;
      String? paymentStatus;
      bool? admincutstatus;
      num? depositBalance;
      User? seller;
      User? depositor;
      String? sellerphoneNumber;
      String? depositorphoneNumber;
      String? transactionId;
      String? paymentType;
      String? createdAt;


      Fund(
      this.id,
      this.paymentStatus,
      this.admincutstatus,
      this.depositBalance,
      this.seller,
      this.depositor,
      this.sellerphoneNumber,
      this.depositorphoneNumber,
      this.transactionId,
      this.paymentType,
      this.createdAt);

  factory Fund.fromJson(Map<String,dynamic>json)=>
          _$FundFromJson(json);
      Map<String,dynamic>toJson()=>_$FundToJson(this);
}
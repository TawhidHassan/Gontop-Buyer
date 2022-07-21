// ignore_for_file: file_names


import 'package:gontop_buyer/Data/Model/Wallet/Wallet.dart';
import 'package:json_annotation/json_annotation.dart';


part 'UserWalletResponse.g.dart';

@JsonSerializable()
class UserWalletResponse{

      String? status;
      Wallet? userwallet;


      UserWalletResponse(this.status, this.userwallet);

  factory UserWalletResponse.fromJson(Map<String,dynamic>json)=>
          _$UserWalletResponseFromJson(json);
      Map<String,dynamic>toJson()=>_$UserWalletResponseToJson(this);
}
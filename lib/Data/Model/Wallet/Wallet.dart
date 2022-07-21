// ignore_for_file: file_names


import 'package:json_annotation/json_annotation.dart';


part 'Wallet.g.dart';

@JsonSerializable()
class Wallet{

      @JsonKey(name: "_id")
      String? id;
      num? credit;
      num? currentbalance;
      num? debit;


      Wallet(this.id, this.credit, this.currentbalance, this.debit);

  factory Wallet.fromJson(Map<String,dynamic>json)=>
          _$WalletFromJson(json);
      Map<String,dynamic>toJson()=>_$WalletToJson(this);
}
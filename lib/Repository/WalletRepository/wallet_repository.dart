
import 'dart:io';

import 'package:gontop_buyer/Data/Model/AddFund/FundResponse.dart';
import 'package:gontop_buyer/Data/Model/FunrdTransfer/FundTransferResponse.dart';
import 'package:gontop_buyer/Network/WalletNetworkService/wallet_network.dart';
import 'package:logger/logger.dart';

import '../../Data/Model/Wallet/UserWalletResponse.dart';



class WalletRepository{
  var logger = Logger();
  WalletNetwork walletNetwork=WalletNetwork();


  Future createwalletRequest(String? token, String? methos, String? sellerId, String? sellerphone, String? userId, String bkashNum, String transectioId, String ammount) async {
    Map<String, dynamic> data = {
      "seller": sellerId,
      "sellerphoneNumber": sellerphone,
      "depositor": userId,
      "depositorphoneNumber":bkashNum,
      "depositBalance": ammount,
      "transactionId": transectioId,
      "paymentType": methos
    };
    final userRaw=await walletNetwork.createwalletRequest(token,data);
    // logger.d(Login.fromJson(userRaw));
    return userRaw;
  }
  Future  unfriend(String? token, String? userId, String? id, String ammount, String messege) async {
    Map<String, dynamic> data = {
      "transferfrom": userId,
      "transferto": id,
      "transferamount": num.parse(ammount),
      "message": messege
    };
    final userRaw=await walletNetwork.unfriend(token,data);
    // logger.d(Login.fromJson(userRaw));
    return userRaw;
  }

 Future<UserWalletResponse> getUserWallet(String? token, String? id) async{
   final userRaw=await walletNetwork.getUserWallet(token,id);
   // logger.d(Login.fromJson(userRaw));
   return UserWalletResponse.fromJson(userRaw);
 }

 Future<FundTransferResponse> getFunTransferHistory(String? token, String? id) async{
   final userRaw=await walletNetwork.getFunTransferHistory(token,id);
   // logger.d(Login.fromJson(userRaw));
   return FundTransferResponse.fromJson(userRaw);
 }
 Future<FundResponse> getAddFunTransferHistory(String? token, String? id) async{
   final userRaw=await walletNetwork.getAddFunTransferHistory(token,id);
   // logger.d(Login.fromJson(userRaw));
   return FundResponse.fromJson(userRaw);
 }






}
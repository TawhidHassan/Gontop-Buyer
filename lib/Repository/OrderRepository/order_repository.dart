
import 'dart:io';

import 'package:gontop_buyer/Network/WalletNetworkService/wallet_network.dart';
import 'package:logger/logger.dart';

import '../../Bloc/Order/order_cubit.dart';
import '../../Data/Model/Order/OrderResponse.dart';
import '../../Data/Model/Wallet/UserWalletResponse.dart';
import '../../Network/OrderNetworkService/order_network.dart';



class OrderRepository{
  var logger = Logger();
  OrderNetwork orderNetwork=OrderNetwork();


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
    // final userRaw=await walletNetwork.createwalletRequest(token,data);
    // logger.d(Login.fromJson(userRaw));
    // return userRaw;
  }

  Future createOrder(String? token, String? productId, num price,String? gameId, String ign, String inGameName, String fbPass, String fbMaol) async{
    Map<String, dynamic> data = {
      "product": productId,
      "orderPrice": price,
      "gameId": gameId,
      "gameName": inGameName,
      "gid":ign,
      "fbmail": fbMaol,
      "fbpass": fbPass,
    };

    final userRaw=await orderNetwork.createOrder(token,data);

    return userRaw;
  }

 Future<OrderResponse> getUserOrders(String? token, String? userId, String status)async {
   final userRaw=await orderNetwork.getUserOrders(token,userId,status);

   return OrderResponse.fromJson(userRaw);
 }



}
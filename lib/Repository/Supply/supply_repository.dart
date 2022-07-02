
import 'package:logger/logger.dart';

import '../../Data/Model/Supply/AdminSupply.dart';
import '../../Data/Model/Supply/LogResponse.dart';
import '../../Data/Model/Supply/SupplyResponse.dart';
import '../../Network/SupplyNetworkService/supply_network.dart';

class SupplyRepository{
  var logger = Logger();
  SupplyNetwork supplyNetwork=SupplyNetwork();

  Future createGivenSupply(String? token, String amount, String note, String? userId) async{
    Map<String, dynamic> data = {
      "seller": userId,
      "givenBdt": num.parse(amount),
      "note": note,
      "supplyStatus": "Given",
    };
    final userRaw=await supplyNetwork.createGivenSupply(token,data);
    // logger.d(Login.fromJson(userRaw));
    return userRaw;
  }
  Future createTakenSupply(String? token, String amount, String note, String? userId) async{
    Map<String, dynamic> data = {
      "seller": userId,
      "takenBdt": num.parse(amount),
      "note": note,
      "supplyStatus": "Taken",
    };
    final userRaw=await supplyNetwork.createGivenSupply(token,data);
    // logger.d(Login.fromJson(userRaw));
    return userRaw;
  }
  Future<SupplyResponse>  getAllSellerMainLogs(String? token) async{
    final userRaw=await supplyNetwork.getAllSellerMainLogs(token);
    // logger.d(Login.fromJson(userRaw));

    return SupplyResponse.fromJson(userRaw);
  }
  Future<LogResponse>  getFullPAymentLog(String? token, String? userId) async{
    final userRaw=await supplyNetwork.getFullPAymentLog(token,userId);
    // logger.d(Login.fromJson(userRaw));

    return LogResponse.fromJson(userRaw);
  }
  Future<AdminSupply>  getAdminTotalSupplyValue(String? token) async{
    final userRaw=await supplyNetwork.getAdminTotalSupplyValue(token);
    // logger.d(Login.fromJson(userRaw));

    return AdminSupply.fromJson(userRaw);
  }






}
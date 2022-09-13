
import 'dart:convert';
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import '../../Constants/Strings/app_strings.dart';

class WalletNetwork{
  var logger = Logger();


  Future createwalletRequest(String? token, Map<String, dynamic> data) async {
    logger.d(data);
    try {
      var response = await http.post(
        Uri.parse(BASE_URL + "wallet-router/deposit-request"),
        headers: {
          "Authorization": "Bearer " + token!,
          "Content-type": "application/json",
          "Accept": "application/json",
        },
        body: json.encode(data),
      );
      logger.d(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future unfriend(String? token, Map<String, dynamic> data) async {
    logger.d(data);
    try {
      var response = await http.post(
        Uri.parse(BASE_URL + "wallet-router/transfer"),
        headers: {
          "Authorization": "Bearer " + token!,
          "Content-type": "application/json",
          "Accept": "application/json",
        },
        body: json.encode(data),
      );
      logger.d(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
      return null;
    }
  }


  Future getUserWallet(String? token,String? id) async {

    try {
      var response = await http.get(
        Uri.parse(BASE_URL + "wallet-router/user-wallet/"+id!),
        headers: {
          "Authorization": "Bearer " + token!,
          "Content-type": "application/json",
          "Accept": "application/json",
        },
      );
      logger.d(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
      return null;
    }
  }
 Future getFunTransferHistory(String? token,String? id) async {

    try {
      var response = await http.get(
        Uri.parse(BASE_URL + "wallet-router/tranfer-deposit-log/"+id!),
        headers: {
          "Authorization": "Bearer " + token!,
          "Content-type": "application/json",
          "Accept": "application/json",
        },
      );
      logger.d(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
      return null;
    }
  }
 Future getAddFunTransferHistory(String? token,String? id) async {

    try {
      var response = await http.get(
        Uri.parse(BASE_URL + "wallet-router/buyer-deposit-log/"+id!),
        headers: {
          "Authorization": "Bearer " + token!,
          "Content-type": "application/json",
          "Accept": "application/json",
        },
      );
      logger.d(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
      return null;
    }
  }

}

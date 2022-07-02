
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







}

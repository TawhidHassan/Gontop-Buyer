
import 'dart:convert';
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import '../../Constants/Strings/app_strings.dart';

class ProductNetwork{
  var logger = Logger();
  Future createProduct(String? token, String name, String point, String price, String? id, String? categoryId, File? image) async{
    try{
      var request =  http.MultipartRequest(
        'POST', Uri.parse(BASE_URL+"games"),
      );
      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization":"Bearer "+token!,
      };
      //add headers
      request.headers.addAll(headers);
      request.fields['productName'] = name;
      request.files.add(await http.MultipartFile.fromPath('image', image!.path));
      request.fields['game'] = id!;
      request.fields['category'] = categoryId!;
      request.fields['price'] = price;
      request.fields['points'] = point;
      // logger.d(image.path);
      var streamedResponse =await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      logger.d(response.body);
      return json.decode(response.body);
    }catch(e){
      logger.d(e);
      return null;
    }
  }

  Future getAllProduct(String? token) async{
    try{
      var response = await http.get(
        Uri.parse(BASE_URL + "product?limit=&pageNo="),
        headers: {
          "Authorization":"Bearer "+token!,
          "Accept": "application/json"
        },
      );
      logger.d(response.body);
      return jsonDecode(response.body);
    }catch(e){
      print(e);
      return null;
    }

  }

 Future assignProduct(String? token, Map<String, dynamic> data) async{
   logger.d(data);
   try {
     var response = await http.post(
       Uri.parse(BASE_URL + "/seller-product"),
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

import 'package:hive/hive.dart';

class LoginDataSave{

  Future storeTokenUserdata(Box? users,String? token,String? id,String? name,String? email,String? role,String? image, String? phoneNumber) async{
    print(id);
    users?.put("token", token);
    users?.put("name", name);
    users?.put("email", email);
    users?.put("userId", id);
    users?.put("role", role);
    users?.put("image", image);
    users?.put("phoneNumber", phoneNumber);

    print("done");
  }
//login

}
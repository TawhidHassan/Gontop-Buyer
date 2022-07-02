// ignore_for_file: file_names


import 'package:json_annotation/json_annotation.dart';


part 'User.g.dart';

@JsonSerializable()
class User{

  @JsonKey(name: "_id")
  String? id;
  String? name;
  String? email;
  String? role;
  String? image;
  String? phoneNumber;


  User(this.id, this.name, this.email, this.role, this.image, this.phoneNumber);

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, role: $role, image: $image, phoneNumber: $phoneNumber}';
  }

  factory User.fromJson(Map<String,dynamic>json)=>
      _$UserFromJson(json);
  Map<String,dynamic>toJson()=>_$UserToJson(this);
}
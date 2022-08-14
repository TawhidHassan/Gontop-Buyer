
import 'package:flutter/material.dart';

import '../../../Constants/Colors/app_colors.dart';

class OnChangeTextField2 extends StatelessWidget {
  final String lable;
  final String hintText;
  final bool readOnly;
  final Function(String)? tap;
  OnChangeTextField2({Key? key, required this.lable,required this.controller, required this.hintText,required this.readOnly, required this.tap}) : super(key: key);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return TextFormField(
      style: TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please fillup';
        }
        return null;
      },
      onChanged: tap,
      readOnly: readOnly,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: lable,
        hintStyle: TextStyle(color: Colors.white),
        labelStyle: TextStyle(color: Colors.white),
        contentPadding:
        EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color:textFieldBorder, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: Colors.lightBlueAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';

import '../../../Constants/Colors/app_colors.dart';

class MaterialTextFieldBackground extends StatelessWidget {
  final String lable;
  final String hintText;
  final bool readOnly;
  final Icon icon;
  MaterialTextFieldBackground({required this.lable,required this.controller, required this.hintText,required this.readOnly, required this.icon});
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
      readOnly: readOnly,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: icon,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
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
          BorderSide(color: Color(0xFFF88A44), width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
    );
  }
}

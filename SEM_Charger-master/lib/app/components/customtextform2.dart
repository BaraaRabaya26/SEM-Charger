import 'package:flutter/material.dart';

class CustTextFormSign2 extends StatelessWidget {
  final String hint;
  final String? Function(String?) validator;
  final String label;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool readonly;
  final String init;

//  final TextEditingController controller;

  const CustTextFormSign2({
    Key? key,
    required this.hint,
    required this.label,
    // required this.controller,
    required this.validator,
    required this.keyboardType,
    required this.obscureText,
    required this.readonly,
    required this.init,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        style:  const TextStyle(color: Colors.white,fontSize: 17),
        initialValue: init,
        readOnly: readonly,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        // controller: controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            hintText: hint,
            label: Text(label,style: const TextStyle(color: Colors.white),),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)))),
//
// OutlineInputBor
      ),
    ); // TextFormField
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../utils/color_g.dart';

class TextFormFieldSingInWidget extends StatelessWidget {
  final String textChild;
  final Texthelper;
  final Iconsuffix;
  final TypeKeyboard;
  final obscureText;
  final Controller;

  final vallid_fun;

  TextFormFieldSingInWidget({
    super.key,
    required this.textChild,
    this.Texthelper,
    this.Iconsuffix,
    this.TypeKeyboard,
    required this.Controller,
    required this.vallid_fun,
    required this.obscureText,
    // this.bOT,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: Controller,
      decoration: InputDecoration(
        labelText: textChild,
        filled: true,
        fillColor: ColorG.buttonBackgroundColor,
        helperText: Texthelper,
        suffixIcon: IconButton(
          icon: Icon(
            Iconsuffix,
          ),
          onPressed: () {},
        ),
        helperStyle: TextStyle(color: Colors.teal[200]),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:
              BorderSide(color: Color.fromARGB(255, 168, 190, 197), width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.white,
            width: 1.0,
          ),
        ),
      ),
      keyboardType: TypeKeyboard,
      validator: vallid_fun,
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../utils/color_g.dart';

class TextFormFieldWidget extends StatelessWidget {
  // final colorBackground;
  // final borderform;
  final focusNode;
  final currentFocus;
  final nextFocus;

  final String textChild;
  final Texthelper;
  final Iconsuffix;
  final TypeKeyboard;

  final Controller;
  final MaskTextInputFormatter maskCustom;
  final Function()? onFieldSubmitted;

  // final maskFormatter = MaskTextInputFormatter(
  //   mask: '+7 (###) ###-##-##',
  //   filter: {"#": RegExp(r'[0-9]')},
  //   type: MaskAutoCompletionType.lazy,
  // );

  final vallid_fun;
  // void vallid_fun(String){}

  // final textStyle;

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  TextFormFieldWidget({
    super.key,
    required this.textChild,
    this.Texthelper,
    this.Iconsuffix,
    this.TypeKeyboard,
    required this.Controller,
    required this.vallid_fun,
    required this.maskCustom,
    this.focusNode,
    this.currentFocus,
    this.nextFocus,
    this.onFieldSubmitted,
    // this.bOT,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
      focusNode: focusNode,
      autofocus: true,
      onFieldSubmitted: (_) {
        _fieldFocusChange(context, currentFocus, nextFocus);
      },
      keyboardType: TypeKeyboard,
      validator: vallid_fun,
      inputFormatters: [maskCustom],
    );
  }
}

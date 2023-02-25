import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:payment_app_fl/widgets/text_form_field_singup_widget.dart';

import '../utils/text_style_g.dart';
import '../widgets/text_form_field_singin_widget.dart';

class SinginScreen extends StatefulWidget {
  SinginScreen({super.key});

  @override
  State<SinginScreen> createState() => _SinginScreenState();
}

class _SinginScreenState extends State<SinginScreen> {
  final _emailController = TextEditingController();
  final _pasController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void dispose() {
    _pasController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Column(
            children: [
              SizedBox(
                height: 180,
              ),
              Text(
                'Вход',
                style: const TextStyle(
                    color: Colors.teal,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    TextFormFieldSingInWidget(
                      obscureText: false,
                      textChild: 'Email',
                      Controller: _emailController,
                      vallid_fun: null,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormFieldSingInWidget(
                      textChild: 'Пароль',
                      vallid_fun: (val) =>
                          val!.isEmpty ? 'Введите пароль' : null,
                      Controller: _pasController,
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: ElevatedButton(
                        onPressed: _submiForm,
                        style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(10, 50)),
                          foregroundColor: getColor(Colors.red, Colors.pink),
                          backgroundColor: getColor(
                              Colors.teal, Color.fromARGB(255, 76, 175, 165)),
                        ),
                        child: Text(
                          "Готово",
                          style: TextStyleG.ButtonTextStyle,
                          // selectionColor: Colors.black,
                        ),
                      ),
                    ),
                  ]),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  MaterialStateProperty<Color> getColor(Color color, Color colorPressed) {
    final getColor = (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return colorPressed;
      } else {
        return color;
      }
    };
    return MaterialStateProperty.resolveWith(getColor);
  }

  void _submiForm() {}
}

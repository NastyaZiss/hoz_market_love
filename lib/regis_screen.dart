import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:payment_app_fl/utils/text_style_g.dart';
import 'package:payment_app_fl/widgets/text_form_field_widget.dart';
import 'utils/color_g.dart';

class RegisScreen extends StatefulWidget {
  const RegisScreen({super.key});

  @override
  State<RegisScreen> createState() => _RegisScreenState();
}

class _RegisScreenState extends State<RegisScreen> {
  bool _hidePass = true;

  // final maskFormatter = MackTextInputFormatter();

  final _formKey = GlobalKey<FormState>();

  final maskFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  final _nameController = TextEditingController();
  final _polController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _polController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Регистрация'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormFieldWidget(
              textChild: 'Имя',
              Controller: _nameController,
              maskCustom: MaskTextInputFormatter(),
              vallid_fun: (dynamic value) {
                final _nameExp = RegExp(r'^[А-Яа-я]+$');
                if (value.isEmpty) {
                  return 'Введите имя';
                } else if (!_nameExp.hasMatch(value)) {
                  return 'Это не Имя';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 15,
            ),
            TextFormFieldWidget(
              textChild: 'Пол',
              Controller: _polController,
              vallid_fun: (val) => val.isEmpty ? 'Name is required' : null,
              maskCustom: MaskTextInputFormatter(),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormFieldWidget(
              Texthelper: 'Формат 8 (ххх) ххx-хх-xx',
              textChild: 'Номер телефона',
              TypeKeyboard: TextInputType.phone,
              Controller: _phoneController,
              vallid_fun: (val) => val.isEmpty ? 'Name is required' : null,
              maskCustom: maskFormatter,
            ),
            SizedBox(
              height: 15,
            ),
            TextFormFieldWidget(
              textChild: 'Email',
              TypeKeyboard: TextInputType.emailAddress,
              Controller: _emailController,
              vallid_fun: (val) => val.isEmpty ? 'Name is required' : null,
              maskCustom: MaskTextInputFormatter(),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              // validator: (val) => val.isEmpty? 'Name is required': null,
              validator: null,

              controller: _passController,
              obscureText: _hidePass,
              decoration: InputDecoration(
                labelText: 'Пароль',
                filled: true,
                fillColor: ColorG.buttonBackgroundColor,
                helperText: 'Не менее 8 символов',
                suffixIcon: IconButton(
                  icon: Icon(
                    _hidePass ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _hidePass = !_hidePass;
                    });
                  },
                ),
                helperStyle: TextStyle(color: Colors.teal[200]),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 168, 190, 197), width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: _submiForm,
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(10, 50)),
                foregroundColor: getColor(Colors.red, Colors.pink),
                backgroundColor:
                    getColor(Colors.teal, Color.fromARGB(255, 76, 175, 165)),
              ),
              child: Text(
                "Готово",
                style: TextStyleG.ButtonTextStyle,
                // selectionColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
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

// делаем бордер для кнопки, который при нажатии меняется
  // MaterialStateProperty<BorderSide> getBorder(Color color, Color colorPressed) {
  //   final getBorder = (Set<MaterialState> states) {
  //     if (states.contains(MaterialState.pressed)) {
  //       return BorderSide(color: colorPressed, width: 2);
  //     } else {
  //       return BorderSide(color: color, width: 2);
  //     }
  //   };
  //   return MaterialStateProperty.resolveWith(getBorder);
  // }

  void _submiForm() {
    if (_formKey.currentState!.validate()) {
      print('valid');
    }
    print('имя: ${_nameController}');
    print('pass: ${_passController}');
    print('phone: ${_phoneController}');
    print('pol: ${_polController}');
    print('email: ${_emailController}');
  }
}
// overlayColor:
              //     getColor(Color.fromARGB(255, 49, 237, 218), Colors.teal)),
              // side: getBorder(Colors.red, Colors.black54),
               // maximumSize: MaterialStateProperty.all(const Size(50, 50)),

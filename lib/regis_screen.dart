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

  // final maskFormatter2 = MaskTextInputFormatter(
  //   mask: '###@.###',
  //   filter: {"#": RegExp("*{3,20}@*{3,20}")},
  //   type: MaskAutoCompletionType.lazy,
  // );

  // $("input#email").inputmask({
  //               mask: ,
  //               greedy: false,
  //               clearMaskOnLostFocus: false
  //           });

  List<String> _countries = ['Мужской', 'Женский', 'Нет'];
  final _namefocus = FocusNode();
  final _polfocus = FocusNode();
  final _phonefocus = FocusNode();
  final _pasfocus = FocusNode();
  final _emailfocus = FocusNode();
  // late String _selectedCountry;

  final _nameController = TextEditingController();
  final _polController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedCountry;

  @override
  void dispose() {
    _nameController.dispose();
    _polController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _phoneController.dispose();
    _namefocus.dispose();
    _emailfocus.dispose();
    _phonefocus.dispose();
    _pasfocus.dispose();
    _emailfocus.dispose();
    _polfocus.dispose();
    super.dispose();
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Регистрация'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              TextFormFieldWidget(
                focusNode: _namefocus,
                currentFocus: _namefocus,
                nextFocus: _polfocus,
                textChild: ('Имя'),
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
              Container(
                child: DropdownButtonFormField(
                  // autofocus: true,
                  focusNode: _polfocus,
                  onSaved: (_) {
                    _fieldFocusChange(context, _polfocus, _phonefocus);
                  },
                  items: _countries.map((country) {
                    return DropdownMenuItem(
                      child: Text(country),
                      value: country,
                    );
                  }).toList(),
                  onChanged: (data) {
                    print(data);
                    setState(() {
                      _selectedCountry = data as String?;
                    });
                  },
                  disabledHint: Text("ytn"),
                  dropdownColor: ColorG.buttonBackgroundColor,
                  value: _selectedCountry,
                  style: TextStyle(color: Color.fromARGB(255, 168, 190, 197)),
                  decoration: InputDecoration(
                    labelText: 'Пол',
                    filled: true,
                    fillColor: ColorG.buttonBackgroundColor,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 168, 190, 197),
                          width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormFieldWidget(
                currentFocus: _phonefocus,
                nextFocus: _emailfocus,
                focusNode: _phonefocus,
                Texthelper: 'Формат 8 (ххх) ххx-хх-xx',
                textChild: 'Номер телефона',
                TypeKeyboard: TextInputType.phone,
                Controller: _phoneController,
                vallid_fun: (val) =>
                    val.isEmpty ? 'Введите свой номер телефона' : null,
                maskCustom: maskFormatter,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormFieldWidget(
                focusNode: _emailfocus,
                currentFocus: _emailfocus,
                nextFocus: _pasfocus,
                textChild: 'Email',
                TypeKeyboard: TextInputType.emailAddress,
                Controller: _emailController,
                vallid_fun: (val) => val.isEmpty ? 'Введите свой  email' : null,
                maskCustom: MaskTextInputFormatter(),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                autofocus: true,
                focusNode: _pasfocus,
                validator: (val) => val!.isEmpty ? 'Введите пароль' : null,
                controller: _passController,
                obscureText: _hidePass,
                decoration: InputDecoration(
                  labelText: 'Пароль',
                  filled: true,
                  fillColor: ColorG.buttonBackgroundColor,
                  helperText: 'Не менее 8 символов',
                  suffixIcon: IconButton(
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Icon(
                        _hidePass ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _hidePass = !_hidePass;
                      });
                    },
                  ),
                  helperStyle: TextStyle(color: Colors.teal[200]),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 168, 190, 197), width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
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
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: ElevatedButton(
                  onPressed: _submiForm,
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(10, 50)),
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
            ],
          ),
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

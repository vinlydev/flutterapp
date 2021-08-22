import 'package:flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  _register(Map<String, dynamic> values) async {
    print(values);
    var url = Uri.parse('https://api.codingthailand.com/api/register');
    var abody = convert.jsonEncode({
      'name': values['name'],
      'email': values['email'],
      'password': values['password'],
      'dob': values['dob']
    });
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: abody);
    print(convert.jsonDecode(abody));
    if (response.statusCode == 201) {
      // var feedback = convert.jsonDecode(response.body);
      // Flushbar(
      //   title: '${feedback['message']}',
      //   message: "ລົງທະບຽນສຳເລັດ",
      //   icon: Icon(
      //     Icons.info_outline,
      //     size: 28.0,
      //     color: Colors.blue[300],
      //   ),
      //   duration: Duration(seconds: 3),
      //   leftBarIndicatorColor: Colors.black87,
      // )..show(context);
      // print(response.body);
    } else {
      // print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('ລົງທະບຽນ')),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.white70, Colors.blue])),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: FormBuilder(
                      key: _formKey,
                      initialValue: {
                        'name': '',
                        'email': '',
                        'password': '',
                        //'dob': DateTime.now(),
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: <Widget>[
                          FormBuilderTextField(
                            name: "name",
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                labelText: "ຊື່ ແລະ ນາມສະກຸນ",
                                labelStyle: TextStyle(color: Colors.black87),
                                fillColor: Colors.white30,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                errorStyle: TextStyle(color: Colors.white)),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context,
                                  errorText: 'ກະລຸນາໃສ່ ຊື່ ແລະ ນາມສະກຸນ'),
                            ]),
                          ),
                          SizedBox(height: 20),
                          FormBuilderTextField(
                            name: "email",
                            maxLines: 1,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle: TextStyle(color: Colors.black87),
                                fillColor: Colors.white30,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                errorStyle: TextStyle(color: Colors.white)),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context,
                                  errorText: 'ກະລຸນາໃສ່ອີເມວ'),
                              FormBuilderValidators.email(context,
                                  errorText: 'ກະລຸນາກວດເບິ່ງອີເມວຄືນ')
                            ]),
                          ),
                          SizedBox(height: 20),
                          FormBuilderTextField(
                            name: "password",
                            maxLines: 1,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: TextStyle(color: Colors.black87),
                                fillColor: Colors.white30,
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                errorStyle: TextStyle(color: Colors.white)),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context,
                                  errorText: 'ກະລຸນາໃສ່ລະະຫັດຜ່ານ'),
                              FormBuilderValidators.minLength(context, 3,
                                  errorText: 'ກະລຸນາກວດລະຫັດຜ່ານ 3 ຕົວຂຶ້ນໄປ')
                            ]),
                          ),
                          SizedBox(height: 20),
                          FormBuilderDateTimePicker(
                            name: 'dob',
                            inputType: InputType.date,
                            format: DateFormat("yyyy-MM-dd"),
                            decoration: InputDecoration(
                              labelText: 'ວັນ-ເດືອນ-ປີເກີດ',
                              labelStyle: TextStyle(color: Colors.black87),
                              fillColor: Colors.white30,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                              width: 200,
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                onPressed: () {
                                  _formKey.currentState.save();
                                  print(_formKey.currentState.value);
                                  if (_formKey.currentState.validate()) {
                                    print(_formKey.currentState.value);
                                    _register(_formKey.currentState.value);
                                  } else {
                                    print("validation failed");
                                    print(_formKey.currentState.value);
                                  }
                                },
                                child: Text('ລົງທະບຽນ',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.blueGrey)),
                                padding: EdgeInsets.all(30),
                                color: Colors.tealAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              )),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

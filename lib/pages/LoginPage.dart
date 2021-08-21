import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Image(
                image: AssetImage('assets/img/logo-vsv.png'),
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: FormBuilder(
                  key: _formKey,
                  initialValue: {
                    'email': '',
                    'password': '',
                  },
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    children: <Widget>[
                      FormBuilderTextField(
                        name: 'email',
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email',
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
                        name: 'password',
                        maxLines: 1,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            labelText: 'Password',
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
                              errorText: 'ກະລຸນາກວດລະຫັດຜ່ານຄືນ')
                        ]),
                      ),
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

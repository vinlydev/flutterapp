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
                image: AssetImage('assets/img/logovsv.png'),
                height: 100,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: FormBuilder(
                  key: _formKey,
                  initialValue: {
                    'email': '',
                    'password': '',
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: <Widget>[
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
                      SizedBox(
                          width: 200,
                          // ignore: deprecated_member_use
                          child: RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                print(_formKey.currentState.value);
                              } else {
                                setState(() {
                                  // ignore: unnecessary_statements
                                  AutovalidateMode.onUserInteraction;
                                });
                              }
                            },
                            child: Text('ເຂົ້າລະບົບ',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.blueGrey)),
                            padding: EdgeInsets.all(30),
                            color: Colors.tealAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          )),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: MaterialButton(
                              child: Text(
                                'ລົງທະບຽນ',
                                style: TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/register');
                              },
                            ),
                          ),
                          Expanded(
                            child: MaterialButton(
                              child: Text(
                                'ລືມລະຫັດຜ່ານ',
                                style: TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline),
                              ),
                              onPressed: () {},
                            ),
                          )
                        ],
                      )
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

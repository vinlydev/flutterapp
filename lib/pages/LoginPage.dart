import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flushbar/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;
  SharedPreferences prefs;

  _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  _login(Map<String, dynamic> values) async {
    setState(() {
      isLoading = true;
    });
    // print(values);
    var url = Uri.parse('https://api.codingthailand.com/api/login');
    // var abody =
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: convert.jsonEncode({
          'email': values['email'],
          'password': values['password'],
        }));
    // print(convert.jsonDecode(abody));
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      // var token = convert.jsonDecode(response.body);
      // print(response.body);

      //save token to prefe
      await prefs.setString('token', response.body);

      //get profile
      await _getProfile();

      //go to homepage
      Navigator.pushNamedAndRemoveUntil(
          context, '/homestack', (Route<dynamic> route) => false);
    } else {
      setState(() {
        isLoading = false;
      });
      var feedback = convert.jsonDecode(response.body);
      Flushbar(
        title: '${feedback['message']}',
        message: "ເກີດຂໍ້ຜິດພາດຈາກລະບົບ ${feedback['status_code']}",
        backgroundColor: Colors.redAccent,
        icon: Icon(
          Icons.error,
          size: 28.0,
          color: Colors.red[300],
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue[300],
      )..show(context);
    }
  }

  Future<void> _getProfile() async {
    //get token from prefs
    var tokenString = prefs.getString('token');
    var token = convert.jsonDecode(tokenString);
    print(token['access_token']);

    //http get profile
    var url = Uri.parse('https://api.codingthailand.com/api/profile');
    var response = await http.get(url,
        headers: {'Authorization': 'Bearer ${token['access_token']}'});
    print(response.body);

    //save user profile to prefs
    var profile = convert.jsonDecode(response.body);
    await prefs.setString(
        'profile', convert.jsonEncode(profile['data']['user']));
  }

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
                              _formKey.currentState.saveAndValidate();
                              // print(_formKey.currentState.value);
                              if (_formKey.currentState.validate()) {
                                // print(_formKey.currentState.value);
                                _login(_formKey.currentState.value);
                              } else {
                                print("validation failed");
                                // print(_formKey.currentState.value);
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

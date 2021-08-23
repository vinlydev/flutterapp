import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flushbar/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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

  _updateProfile(Map<String, dynamic> values) async {
    setState(() {
      isLoading = true;
    });

    //get token
    var tokenString = prefs.getString('token');
    var token = convert.jsonDecode(tokenString);

    // print(values);
    var url = Uri.parse('https://api.codingthailand.com/api/editprofile');
    // var abody =
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token['access_token']}'
        },
        body: convert.jsonEncode({
          'name': values['name'],
        }));
    // print(convert.jsonDecode(abody));
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });

      //save profile to prefs
      var profile = response.body;
      await _saveProfile(profile);

      //go to homepage
      Navigator.pushNamedAndRemoveUntil(
          context, 'homestack/home', (Route<dynamic> route) => false);
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

  Future<void> _saveProfile(String profile) async {
    //save user profile to prefs
    var profileUpdate = convert.jsonDecode(profile);
    await prefs.setString(
        'profile', convert.jsonEncode(profileUpdate['data']['user']));
  }

  @override
  Widget build(BuildContext context) {
    Map user = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text('ແກ້ໄຂຂໍ້ມູນສ່ວນຕົວ')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
              child: FormBuilder(
                key: _formKey,
                initialValue: {
                  'name': user['name'],
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
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
                          errorStyle: TextStyle(color: Colors.red)),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context,
                            errorText: 'ກະລຸນາໃສ່ ຊື່ ແລະ ນາມສະກຸນ'),
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
                              _updateProfile(_formKey.currentState.value);
                            } else {
                              print("validation failed");
                              // print(_formKey.currentState.value);
                            }
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                isLoading == true
                                    ? CircularProgressIndicator()
                                    : Text(''),
                                Text('ແກ້ໄຂ',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.blueGrey)),
                              ]),
                          padding: EdgeInsets.all(30),
                          color: Colors.tealAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

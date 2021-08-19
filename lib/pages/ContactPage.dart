import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  ContactPage({Key key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Call US')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('ຕິດຕໍ່ເຮົາ'),
            RaisedButton(
              child: Text('ກັບໜ້າຫຼັກ'),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, 'homestack/home', (Route<dynamic> route) => false);
              },
            )
          ],
        ),
      ),
    );
  }
}

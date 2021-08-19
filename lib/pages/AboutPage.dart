import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> company = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('AboutUS'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('CodingThailand.com'),
            SizedBox(height: 30),
            Text('Email: ${company['email']}'),
            Text('Phone: ${company['phone']}'),
            Divider(),
            RaisedButton(
              child: Text('ໜ້າຫຼັກ'),
              onPressed: () {
                Navigator.pop(context, 'About Page');
              },
            ),
            RaisedButton(
              child: Text('ຕິດຕໍ່ເຮົາ'),
              onPressed: () {
                Navigator.pushNamed(context, 'homestack/contact');
              },
            )
          ],
        ),
      ),
    );
  }
}

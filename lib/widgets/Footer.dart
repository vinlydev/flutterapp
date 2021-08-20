import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  Footer({Key key}) : super(key: key);

  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  String companyName = 'CCT';

  void _changeCompanyName() {
    setState(() {
      companyName = 'Flutter';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('$companyName'),
        // ignore: deprecated_member_use
        RaisedButton(
          onPressed: _changeCompanyName,
          child: Text('Click Me!!!'),
        )
      ],
    );
  }
}

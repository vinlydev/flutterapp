import 'package:flutter/material.dart';
import 'package:flutterapp/widgets/menu.dart';

class CameraPage extends StatefulWidget {
  CameraPage({Key key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(title: Text('ຖ່າຍຮູບ')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('ກ້ອງຖ່າຍຮູບ'),
          ],
        ),
      ),
    );
  }
}

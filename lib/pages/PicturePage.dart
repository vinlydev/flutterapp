import 'package:flutter/material.dart';

class PicturePage extends StatefulWidget {
  PicturePage({Key key}) : super(key: key);

  @override
  _PicturePageState createState() => _PicturePageState();
}

class _PicturePageState extends State<PicturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('picture')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('picture'),
          ],
        ),
      ),
    );
  }
}

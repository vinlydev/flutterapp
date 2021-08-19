import 'package:flutter/material.dart';

class CompanyPage extends StatefulWidget {
  CompanyPage({Key key}) : super(key: key);

  @override
  _CompanyPageState createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ຂໍ້ມູນບໍລິສັດ')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildHedaer(),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(children: <Widget>[
                  Text('LANIC',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  Divider(),
                  Text(
                    'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
                    textAlign: TextAlign.left,
                  ),
                  Divider(),
                  SizedBox(height: 20),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                            children: [Icon(Icons.phone, color: Colors.red)]),
                        SizedBox(width: 16),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(children: [Text('Vinly')]),
                              Row(children: [Text('+85620-5955-5552')])
                            ]),
                      ]),
                  Divider(),
                  Wrap(
                    spacing: 8,
                    children: List.generate(
                      7,
                      (int index) => Chip(
                        label: Text('Hello ${index + 1}'),
                        avatar: Icon(Icons.star),
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ),
                  Divider(),
                  buildFooter()
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  //header image
  Image buildHedaer() {
    return Image(
      image: AssetImage('assets/img/packing.png'),
      fit: BoxFit.cover,
    );
  }

  //footer
  Row buildFooter() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage('assets/img/manager.png'),
            radius: 40,
          ),
          CircleAvatar(
            backgroundImage: AssetImage('assets/img/manager.png'),
            radius: 40,
          ),
          CircleAvatar(
            backgroundImage: AssetImage('assets/img/manager.png'),
            radius: 40,
          ),
          SizedBox(
              width: 60,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Icon(Icons.access_alarm),
                    Icon(Icons.accessibility),
                    Icon(Icons.account_balance),
                  ]))
        ]);
  }
}

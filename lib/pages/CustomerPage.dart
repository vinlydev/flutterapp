import 'package:flutter/material.dart';

class CustomerPage extends StatefulWidget {
  CustomerPage({Key key}) : super(key: key);

  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  List<Map> customer = [];

  _getCustomer() async {}

  @override
  void initState() {
    super.initState();
    _getCustomer();
  }

  _insertForm() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ລູກຄ້າ'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.person_add),
              onPressed: () {
                _insertForm();
              },
            )
          ],
        ),
        body: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  title: Text(''),
                  subtitle: Text(''),
                  trailing: Chip(
                    label: Text(''),
                    backgroundColor: Colors.redAccent,
                  ));
            },
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: customer.length));
  }
}

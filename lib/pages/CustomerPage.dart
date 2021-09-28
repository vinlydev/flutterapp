import 'package:flutter/material.dart';
import 'package:flutterapp/utils/database.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sqflite/sqflite.dart';

class CustomerPage extends StatefulWidget {
  CustomerPage({Key key}) : super(key: key);

  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  List<Map> customers = [];
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool _autovalidate = false;
  DBHelper dbHelper;
  Database db;

  _getCustomer() async {
    db = await dbHelper.db;
    var cust = await db.rawQuery('SELECT * FROM customers ORDER BY id DESC');
    setState(() {
      customers = cust;
    });
  }

  _insertCustomer(Map values) async {
    db = await dbHelper.db;
    await db.rawInsert('INSERT INTO customers (name, phone) VALUES (?, ?)',
        [values['name'], values['phone']]);
    _getCustomer();
    print('inserted');
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();

    _getCustomer();
  }

  _insertForm() {
    Alert(
        context: context,
        title: "ເພີ່ມຂໍ້ມູນລູກຄ້າ",
        closeFunction: () {},
        content: Column(
          children: <Widget>[
            FormBuilder(
              key: _formKey,
              initialValue: {'name': '', 'phone': ''},
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: <Widget>[
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
                  SizedBox(height: 30),
                  FormBuilderTextField(
                    name: "phone",
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: "ເບິີໂທລະສັບ",
                        labelStyle: TextStyle(color: Colors.black87),
                        fillColor: Colors.white30,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        errorStyle: TextStyle(color: Colors.red)),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context,
                          errorText: 'ກະລຸນາໃສ່ ເບີໂທລະສັບ'),
                    ]),
                  ),
                ],
              ),
            )
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              // Navigator.pop(context);
              if (_formKey.currentState.validate()) {
                // print(_formKey.currentState.value);
                _insertCustomer(_formKey.currentState.value);
                Navigator.of(context).pop();
              } else {
                setState(() {
                  _autovalidate = true;
                });
              }
            },
            child: Text(
              "ເພີ່ມລູກຄ້າ",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

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
                  title: Text('${customers[index]['id']}'),
                  subtitle: Text('${customers[index]['name']}'),
                  trailing: Chip(
                    label: Text('${customers[index]['phone']}'),
                    backgroundColor: Colors.redAccent,
                  ));
            },
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: customers.length));
  }
}

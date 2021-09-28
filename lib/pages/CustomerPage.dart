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
  // ignore: unused_field
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

  // ignore: unused_element
  _updateCustomer(int id, Map values) async {
    db = await dbHelper.db;
    await db.rawUpdate('UPDATE customers set name=?, phone=? WHERE id=?',
        [values['name'], values['phone'], id]);
    _getCustomer();
    print('updated');
  }

  // ignore: unused_element
  _deleteCustomer(int id) async {
    db = await dbHelper.db;
    await db.rawDelete('DELETE FROM customers WHERE id=?', [id]);
    _getCustomer();
    print('deleted');
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();

    _getCustomer();
  }

//insert
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
              if (_formKey.currentState.saveAndValidate()) {
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

  //update
  _updateForm(int id, String name, String phone) {
    Alert(
        context: context,
        title: "ແກ້ໄຂຂໍ້ມູນລູກຄ້າ",
        closeFunction: () {},
        content: Column(
          children: <Widget>[
            FormBuilder(
              key: _formKey,
              initialValue: {'name': '$name', 'phone': '$phone'},
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
              if (_formKey.currentState.saveAndValidate()) {
                // print(_formKey.currentState.value);
                _updateCustomer(id, _formKey.currentState.value);
                Navigator.of(context).pop();
              } else {
                setState(() {
                  _autovalidate = true;
                });
              }
            },
            child: Text(
              "ແກ້ໄຂລູກຄ້າ",
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
              return Dismissible(
                child: ListTile(
                    title: Text('${customers[index]['name']}'),
                    subtitle: Text('${customers[index]['id']}'),
                    trailing: Chip(
                      label: Text('${customers[index]['phone']}'),
                      backgroundColor: Colors.redAccent,
                    )),
                key: Key(customers[index]['id'].toString()),
                background: Container(
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 20),
                      Icon(Icons.edit, color: Colors.white),
                      Text('ແກ້ໄຂ',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(width: 20),
                      Icon(Icons.delete, color: Colors.white),
                      Text('ລືບ',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.endToStart) {
                    Alert(
                      context: context,
                      type: AlertType.warning,
                      title: "ທ່ານຕ້ອງການລືບຂໍ້ມູນແທ້ບໍ່?",
                      desc:
                          "ທ່ານແນ່ໃຈລະບໍ່ວ່າຈະລືບ ${customers[index]['name']} ຫຼື ບໍ່?",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "ຕົກລົງ",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            _deleteCustomer(customers[index]['id']);
                          },
                          color: Color.fromRGBO(0, 179, 134, 1.0),
                        ),
                        DialogButton(
                          child: Text(
                            "ຍົກເລີກ",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(116, 116, 191, 1.0),
                            Color.fromRGBO(52, 138, 199, 1.0)
                          ]),
                        )
                      ],
                    ).show();
                  } else {
                    _updateForm(customers[index]['id'],
                        customers[index]['name'], customers[index]['phone']);
                  }
                  return false;
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: customers.length));
  }
}

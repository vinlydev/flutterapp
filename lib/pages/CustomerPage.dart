import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomerPage extends StatefulWidget {
  CustomerPage({Key key}) : super(key: key);

  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  List<Map> customer = [];
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool _autovalidate = false;

  _getCustomer() async {}

  @override
  void initState() {
    super.initState();
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
              initialValue: {
                'name': '',
                'phone': '',
              },
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
                print(_formKey.currentState.value);
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

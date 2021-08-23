import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Menu extends StatefulWidget {
  Menu({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Map<String, dynamic> profile = {'email': '', 'name': '', 'role': ''};

  _getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var profileString = prefs.getString('profile');
    if (profileString != null) {
      setState(() {
        profile = convert.jsonDecode(profileString);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.70,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // DrawerHeader(
            //   decoration: BoxDecoration(
            //     color: Colors.blue,
            //   ),
            //   child: Text(
            //     'ເມນູຫຼັກ',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 24,
            //     ),
            //   ),
            // ),
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/img/kg.png'),
              ),
              accountEmail:
                  Text('${profile['email']} role: ${profile['role']} '),
              accountName: Text('${profile['name']}'),
              otherAccountsPictures: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                )
              ],
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('ໜ້າຫຼັກ'),
              trailing: Icon(Icons.arrow_right),
              selected: ModalRoute.of(context).settings.name == 'homestack/home'
                  ? true
                  : false,
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamedAndRemoveUntil(
                        '/homestack', (Route<dynamic> route) => false);
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('ສິນຄ້າ'),
              trailing: Icon(Icons.arrow_right),
              selected:
                  ModalRoute.of(context).settings.name == 'productstack/product'
                      ? true
                      : false,
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamedAndRemoveUntil(
                        '/productstack', (Route<dynamic> route) => false);
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('ຂ່າວສານ'),
              trailing: Icon(Icons.arrow_right),
              selected: ModalRoute.of(context).settings.name == 'newsstack/news'
                  ? true
                  : false,
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamedAndRemoveUntil(
                        '/newsstack', (Route<dynamic> route) => false);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('ຕັ້ງຄ່າ'),
            ),
          ],
        ),
      ),
    );
  }
}

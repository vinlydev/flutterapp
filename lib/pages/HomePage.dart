import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutterapp/redux/appReducer.dart';
import 'package:flutterapp/redux/profile/profileReducer.dart';
import 'package:flutterapp/widgets/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var fromAbout;

  _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('profile');
    Navigator.of(context, rootNavigator: true)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    print('home build');
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                _logout();
              })
        ],
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img/wallpaper.png'),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: <Widget>[
              StoreConnector<AppState, ProfileState>(
                distinct: true,
                converter: (store) => store.state.profileState,
                builder: (context, profileState) {
                  print('connector build');
                  return Expanded(
                    flex: 1,
                    child: Center(
                        child: Text(
                            'ຍິນດີຕອນຮັບທ່ານ ${profileState.profile['name']}')),
                  );
                },
              ),
              Expanded(
                flex: 9,
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'homestack/company');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.business,
                              size: 80,
                              color: Colors.blueGrey,
                            ),
                            Text(
                              'ບໍລິສັດ',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        color: Colors.white70,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.map, size: 80, color: Colors.blueGrey),
                          Text(
                            'ແຜ່ນທີ່',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      color: Colors.white70,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.camera, size: 80, color: Colors.blueGrey),
                          Text(
                            'ກ້ອງ',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      color: Colors.white70,
                    ),
                    GestureDetector(
                      onTap: () async {
                        fromAbout = await Navigator.pushNamed(
                            context, 'homestack/about', arguments: {
                          'email': 'villy3355@gmail.com',
                          'phone': '85620-5955-5552'
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.person,
                              size: 80,
                              color: Colors.blueGrey,
                            ),
                            Text(
                              'ກ່ຽວກັບເຮົາ ${fromAbout ?? ''}',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        color: Colors.white70,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'homestack/room');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.person,
                              size: 80,
                              color: Colors.blueGrey,
                            ),
                            Text(
                              'ຫ້ອງພັກ ${fromAbout ?? ''}',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

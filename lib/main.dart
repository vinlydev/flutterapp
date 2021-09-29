import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutterapp/pages/CameraStack.dart';
import 'package:flutterapp/pages/CustomerPage.dart';
import 'package:flutterapp/pages/HomeStack.dart';
import 'package:flutterapp/pages/LoginPage.dart';
import 'package:flutterapp/pages/NewsStack.dart';
import 'package:flutterapp/pages/ProductStack.dart';
import 'package:flutterapp/pages/RegisterPage.dart';
import 'package:flutterapp/redux/appReducer.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';

//redux
import 'package:redux/redux.dart';

String token;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString('token');

  final store = Store<AppState>(appReducer,
      initialState: AppState.initial(), middleware: [thunkMiddleware]);

  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({this.store});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          title: 'CodingThailand',
          theme: ThemeData(
              // primarySwatch: Colors.blue,
              primaryColor: Colors.blue,
              // ignore: deprecated_member_use
              accentColor: Colors.blueAccent,
              canvasColor: Colors.blue[50],
              textTheme: TextTheme(
                // ignore: deprecated_member_use
                headline1: TextStyle(color: Colors.blue, fontSize: 30),
              )),
          // home: HomePage(),
          initialRoute: '/',
          routes: <String, WidgetBuilder>{
            '/': (context) => token == null ? LoginPage() : HomeStack(),
            '/register': (context) => RegisterPage(),
            '/login': (context) => LoginPage(),
            '/homestack': (context) => HomeStack(),
            '/productstack': (context) => ProductStack(),
            '/newsstack': (context) => NewsStack(),
            '/customer': (context) => CustomerPage(),
            '/camerastack': (context) => CameraStack(),
            // '/about': (context) => AboutPage(),
            // '/contact': (context) => ContactPage(),
          },
          debugShowCheckedModeBanner: false,
        ));
  }
}

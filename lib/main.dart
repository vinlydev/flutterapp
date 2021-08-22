import 'package:flutter/material.dart';
import 'package:flutterapp/pages/HomeStack.dart';
import 'package:flutterapp/pages/LoginPage.dart';
import 'package:flutterapp/pages/NewsStack.dart';
import 'package:flutterapp/pages/ProductStack.dart';
import 'package:flutterapp/pages/RegisterPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

String token;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString('token');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CodingThailand',
      theme: ThemeData(
          // primarySwatch: Colors.blue,
          primaryColor: Colors.blue,
          accentColor: Colors.blueAccent,
          canvasColor: Colors.blue[50],
          textTheme: TextTheme(
            // ignore: deprecated_member_use
            headline: TextStyle(color: Colors.blue, fontSize: 30),
          )),
      // home: HomePage(),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => token == null ? LoginPage() : HomeStack(),
        '/register': (context) => RegisterPage(),
        '/login': (context) => LoginPage(),
        '/homestack': (context) => HomeStack(),
        '/productstack': (context) => ProductStack(),
        '/newsstack': (context) => NewsStack()
        // '/about': (context) => AboutPage(),
        // '/contact': (context) => ContactPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

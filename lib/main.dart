import 'package:flutter/material.dart';
// import 'package:flutterapp/pages/HomeStack.dart';
import 'package:flutterapp/pages/LoginPage.dart';
import 'package:flutterapp/pages/NewsStack.dart';
import 'package:flutterapp/pages/ProductStack.dart';
import 'package:flutterapp/pages/RegisterPage.dart';

void main() {
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
        // '/': (context) => HomeStack(),
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/productstack': (context) => ProductStack(),
        '/newsstack': (context) => NewsStack()
        // '/about': (context) => AboutPage(),
        // '/contact': (context) => ContactPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

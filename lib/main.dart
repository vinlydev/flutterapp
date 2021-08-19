import 'package:flutter/material.dart';
import 'package:flutterapp/pages/HomeStack.dart';
import 'package:flutterapp/pages/ProductStack.dart';

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
            headline: TextStyle(color: Colors.blue, fontSize: 30),
          )),
      // home: HomePage(),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => HomeStack(),
        '/productstack': (context) => ProductStack()
        // '/about': (context) => AboutPage(),
        // '/contact': (context) => ContactPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

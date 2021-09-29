import 'package:flutter/material.dart';
import 'package:flutterapp/pages/CameraPage.dart';
import 'package:flutterapp/pages/PicturePage.dart';

class CameraStack extends StatefulWidget {
  CameraStack({Key key}) : super(key: key);

  @override
  _CameraStackState createState() => _CameraStackState();
}

class _CameraStackState extends State<CameraStack> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'camerastack/camera',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'camerastack/camera':
            builder = (BuildContext context) => CameraPage();
            break;

          case 'camerastack/picture':
            builder = (BuildContext context) => PicturePage();
            break;

          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute<void>(builder: builder, settings: settings);
      },
    );
  }
}

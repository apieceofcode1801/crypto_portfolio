import 'package:flutter/material.dart';
import 'package:portfolio/app/ui/router.dart' as router;
import 'package:portfolio/app/locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                primary: Colors.white, backgroundColor: Colors.blue),
          ),
          accentColor: Colors.amberAccent,
          primaryColor: Colors.blue),
      onGenerateRoute: router.Router.generateRoute,
    );
  }
}

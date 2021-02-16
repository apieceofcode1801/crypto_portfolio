import 'package:flutter/material.dart';
import 'package:portfolio/ui/router.dart' as router;
import 'package:portfolio/locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      onGenerateRoute: router.Router.generateRoute,
    );
  }
}

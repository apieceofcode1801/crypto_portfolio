import 'package:flutter/material.dart';
import 'package:portfolio/core/consts/routes.dart';
import 'package:portfolio/ui/router.dart' as router;
import 'package:portfolio/locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      initialRoute: Routes.home,
      onGenerateRoute: router.Router.generateRoute,
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/app/ui/router.dart' as router;
import 'package:portfolio/app/locator.dart';

void main() {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initFirebaseApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
              color: Colors.red,
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return _app();
          }

          return Container(
            child: Center(
              child: const CircularProgressIndicator(),
            ),
          );
        },
        future: _initFirebaseApp,
      );
    } else {
      return _app();
    }
  }

  Widget _app() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portfolio Pro',
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

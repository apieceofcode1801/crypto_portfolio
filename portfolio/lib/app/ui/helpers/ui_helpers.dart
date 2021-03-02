import 'dart:math';

import 'package:flutter/material.dart';

class UIHelpers {
  static Color generateRandomColor() {
    final random = Random();
    final red = random.nextInt(255);
    final green = random.nextInt(255);
    final blue = random.nextInt(255);
    // final alpha = random.nextInt(255);

    return Color.fromARGB(255, red, green, blue);
  }
}

void showAlertDialog(
    {@required BuildContext context,
    String title = '',
    String content = '',
    Function onContinue}) {
  final cancelButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text('Cancel'));
  final continueButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
        onContinue();
      },
      child: Text('Continue'));

  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [cancelButton, continueButton],
  );
  showDialog(
    context: context,
    builder: (context) => alert,
  );
}

void showWidgetDialog({BuildContext context, Widget child, String title = ''}) {
  showDialog(
      context: context,
      builder: (_) => WillPopScope(
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(title),
                actions: [
                  IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              ),
              body: Container(
                child: child,
              ),
            ),
            onWillPop: () async => false,
          ),
      barrierDismissible: false);
}

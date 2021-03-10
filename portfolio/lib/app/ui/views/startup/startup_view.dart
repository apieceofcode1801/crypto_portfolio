import 'package:flutter/material.dart';
import 'package:portfolio/app/consts/routes.dart';
import 'package:portfolio/app/ui/views/startup/startup_viewmodel.dart';
import 'package:portfolio/core/base_view.dart';

class StartupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<StartupViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          body: Container(
            color: Colors.white,
            child: Container(
              child: Center(
                child: Text(
                  'portfolio PRO 2021'.toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.amber),
                ),
              ),
            ),
          ),
        );
      },
      onModelReady: (model) async {
        final hasUser = await model.initialise();
        if (hasUser) {
          Navigator.pushReplacementNamed(context, Routes.dashboard);
        } else {
          Navigator.pushReplacementNamed(context, Routes.auth);
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:portfolio/core/consts/routes.dart';
import 'package:portfolio/ui/views/base/base_view.dart';
import 'package:portfolio/ui/views/base/base_viewmodel.dart';
import 'package:portfolio/ui/views/startup/startup_viewmodel.dart';

class StartupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<StartupViewModel>(
      builder: (context, model, child) {
        return Container(
          color: Colors.amber,
        );
      },
      onModelReady: (model) async {
        await model.initialise();
        Navigator.pushNamed(context, Routes.dashboard);
      },
    );
  }
}

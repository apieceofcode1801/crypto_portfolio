import 'package:flutter/material.dart';
import 'package:portfolio/app/consts/routes.dart';
import 'package:portfolio/app/ui/views/startup/startup_viewmodel.dart';
import 'package:portfolio/core/base_view.dart';
import 'package:portfolio/core/enums/viewstate.dart';

class StartupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<StartupViewModel>(
      builder: (context, model, child) {
        return Container(
          color: Colors.amber,
          child: model.state == ViewState.Busy
              ? Center(child: CircularProgressIndicator())
              : Container(),
        );
      },
      onModelReady: (model) async {
        await model.initialise();
        Navigator.pushReplacementNamed(context, Routes.dashboard);
      },
    );
  }
}

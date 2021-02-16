import 'package:flutter/material.dart';
import 'package:portfolio/ui/views/base/base_view.dart';
import 'package:portfolio/ui/views/dashboard/dashboard_viewmodel.dart';

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<DashboardViewModel>(
      builder: (context, model, child) {
        return Container(
          color: Colors.red,
        );
      },
    );
  }
}

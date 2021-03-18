import 'package:flutter/material.dart';

class ScreenSize {
  static bool isSizeSmall(BuildContext context) =>
      MediaQuery.of(context).size.width <= 768;
  static bool isSizeMedium(BuildContext context) =>
      MediaQuery.of(context).size.width > 768 &&
      MediaQuery.of(context).size.width < 1024;
  static bool isSizeLarge(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;
}

class ResponsiveView extends StatelessWidget {
  final Widget small;
  final Widget medium;
  final Widget large;

  const ResponsiveView(
      {Key key,
      @required this.small,
      @required this.medium,
      @required this.large})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ScreenSize.isSizeLarge(context)) {
      return large;
    } else if (ScreenSize.isSizeMedium(context)) {
      return medium;
    } else {
      return small;
    }
  }
}

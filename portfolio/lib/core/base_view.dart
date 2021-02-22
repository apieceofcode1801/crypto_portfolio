import 'package:flutter/material.dart';
import 'package:portfolio/app/locator.dart';
import 'package:provider/provider.dart';

import 'base_viewmodel.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final Function(T) onModelReady;
  final Function(T) didUpdateWidget;

  BaseView({this.builder, this.onModelReady, this.didUpdateWidget});

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  T model = locator<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant BaseView<T> oldWidget) {
    if (widget.didUpdateWidget != null) {
      widget.didUpdateWidget(model);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: model, child: Consumer<T>(builder: widget.builder));
  }

  @override
  void dispose() {
    model.onDispose();
    super.dispose();
  }
}

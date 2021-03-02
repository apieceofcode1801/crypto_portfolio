import 'package:flutter/material.dart';
import 'package:portfolio/app/consts/routes.dart';
import 'package:portfolio/app/ui/helpers/ui_helpers.dart';
import 'package:portfolio/app/ui/views/auth/auth_viewmodel.dart';
import 'package:portfolio/core/base_view.dart';
import 'package:portfolio/core/enums/viewstate.dart';

class AuthView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Authentication'),
          ),
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: model.usernameController,
                        decoration:
                            InputDecoration(hintText: 'Enter your username'),
                        validator: (value) =>
                            value.isEmpty ? 'Invalid username' : null,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: model.passwordController,
                        decoration:
                            InputDecoration(hintText: 'Enter your password'),
                        obscureText: true,
                        validator: (value) =>
                            value.isEmpty ? 'Invalid password' : null,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  await model.login();
                                  if (model.user != null) {
                                    Navigator.pushReplacementNamed(
                                        context, Routes.dashboard);
                                  } else {
                                    showAlertDialog(
                                        context: context,
                                        content: 'Login failed');
                                  }
                                }
                              },
                              child: Text('Login')),
                          const SizedBox(
                            width: 8,
                          ),
                          TextButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  await model.register();
                                  if (model.user != null) {
                                    Navigator.pushReplacementNamed(
                                        context, Routes.dashboard);
                                  } else {
                                    showAlertDialog(
                                        context: context,
                                        content: 'Register failed');
                                  }
                                }
                              },
                              child: Text('Register')),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              model.state == ViewState.Busy
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
            ],
          ),
        );
      },
    );
  }
}

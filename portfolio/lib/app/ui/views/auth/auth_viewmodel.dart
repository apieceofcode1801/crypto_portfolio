import 'package:flutter/material.dart';
import 'package:portfolio/app/consts/consts.dart';
import 'package:portfolio/app/datamodels/user.dart';
import 'package:portfolio/app/locator.dart';
import 'package:portfolio/app/models/user_model.dart';
import 'package:portfolio/app/services/authentication_service.dart';
import 'package:portfolio/app/services/local_storage_service.dart';
import 'package:portfolio/core/base_viewmodel.dart';
import 'package:portfolio/core/enums/viewstate.dart';

class AuthViewModel extends BaseViewModel {
  final _usernameController = TextEditingController();
  TextEditingController get usernameController => _usernameController;
  final _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;
  final _authService = locator<AuthService>();
  final _storageService = locator<LocalStorageService>();
  final _userModel = locator<UserModel>();

  User _user;
  User get user => _user;

  Future login() async {
    setState(ViewState.Busy);
    final user =
        await _authService.getUserWithUsername(_usernameController.text);
    if (user != null) {
      if (user.password == _passwordController.text) {
        _user = user;
        _storageService.save(key: LocalKeys.userId, value: _user.id);
        _userModel.currentUser = user;
        setState(ViewState.Idle);
        return;
      }
    }
    _user = null;
    setState(ViewState.Idle);
  }

  Future register() async {
    setState(ViewState.Busy);
    final user =
        await _authService.getUserWithUsername(_usernameController.text);
    if (user == null) {
      _user = await _authService.createAccount(
          username: _usernameController.text,
          password: _passwordController.text);
      _storageService.save(key: LocalKeys.userId, value: _user.id);
      _userModel.currentUser = user;
      setState(ViewState.Idle);
    } else {
      _user = null;
      setState(ViewState.Idle);
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }
}

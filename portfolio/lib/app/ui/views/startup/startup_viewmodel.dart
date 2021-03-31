import 'package:portfolio/app/consts/consts.dart';
import 'package:portfolio/app/models/user_model.dart';
import 'package:portfolio/app/services/authentication_service.dart';
import 'package:portfolio/app/services/database_service.dart';
import 'package:portfolio/app/services/local_storage_service.dart';
import 'package:portfolio/core/base_viewmodel.dart';
import 'package:portfolio/core/enums/viewstate.dart';
import 'package:portfolio/app/locator.dart';

class StartupViewModel extends BaseViewModel {
  final _databaseService = locator<DatabaseService>();
  final _userModel = locator<UserModel>();
  final _storageService = locator<LocalStorageService>();
  final _authService = locator<AuthService>();

  Future<bool> initialise() async {
    setState(ViewState.Busy);
    await _databaseService.initialise();
    bool hasUser = false;
    final userId = await _storageService.getValue(key: LocalKeys.userId);
    if (userId != null) {
      final user = await _authService.getUser(id: userId);
      if (user != null) {
        _userModel.currentUser = user;
        hasUser = true;
      }
    }
    setState(ViewState.Idle);
    return hasUser;
  }
}

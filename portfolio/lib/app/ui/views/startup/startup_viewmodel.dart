import 'package:portfolio/app/services/database_service.dart';
import 'package:portfolio/core/base_viewmodel.dart';
import 'package:portfolio/core/enums/viewstate.dart';
import 'package:portfolio/app/locator.dart';

class StartupViewModel extends BaseViewModel {
  final _databaseService = locator<DatabaseService>();

  Future initialise() async {
    setState(ViewState.Busy);
    await _databaseService.initialise();
    setState(ViewState.Idle);
  }
}

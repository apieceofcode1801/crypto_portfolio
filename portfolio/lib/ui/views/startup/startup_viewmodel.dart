import 'package:portfolio/core/enums/viewstate.dart';
import 'package:portfolio/core/services/database_service.dart';
import 'package:portfolio/locator.dart';
import 'package:portfolio/ui/views/base/base_viewmodel.dart';

class StartupViewModel extends BaseViewModel {
  DatabaseService _databaseService = locator<DatabaseService>();

  Future initialise() async {
    setState(ViewState.Busy);
    await _databaseService.initialise();
    setState(ViewState.Idle);
  }
}

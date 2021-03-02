import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorageServiceAbstract {
  void save({String key, String value});
  void getValue({String key});
}

class LocalStorageService extends LocalStorageServiceAbstract {
  @override
  dynamic getValue({String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  @override
  void save({String key, String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
}

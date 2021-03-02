import 'package:portfolio/app/datamodels/user.dart';
import 'package:portfolio/app/services/apis/firestore_authen_api.dart';

abstract class AuthenticationServiceAbstract {
  Future createAccount({String username});
  Future<User> getUser({String id});
  Future updateUser({String id, String username});
}

class AuthService extends AuthenticationServiceAbstract {
  final _authApi = FirestoreAuthApi();
  @override
  Future<User> createAccount({String username, String password}) {
    return _authApi.createUser(username: username, password: password);
  }

  @override
  Future<User> getUser({String id}) {
    return _authApi.getUser(id: id);
  }

  Future<User> getUserWithUsername(String username) {
    return _authApi.getUserWithUsername(username: username);
  }

  @override
  Future updateUser({String id, String username}) {
    return _authApi.updateUser(id: id, username: username);
  }
}

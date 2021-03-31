import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portfolio/app/datamodels/user.dart';

abstract class AuthenApiAbstract {
  Future createUser({String username});
  Future updateUser({String id, String username});
  Future<User> getUser({String id});
  Future<User> getUserWithUsername({String username});
}

class FirestoreAuthApi extends AuthenApiAbstract {
  final _users = FirebaseFirestore.instance.collection('users');
  @override
  Future<User> createUser({String username, String password}) async {
    final ref = _users.doc();
    final user = User(id: ref.id, username: username, password: password);
    await ref.set(user.toJson());
    return user;
  }

  @override
  Future updateUser({String id, String username}) {
    return _users.doc(id).set(User(id: id, username: username).toJson());
  }

  @override
  Future<User> getUser({String id}) {
    return _users.doc(id).get().then(
        (value) => value.data() != null ? User.fromJson(value.data()) : null);
  }

  @override
  Future<User> getUserWithUsername({String username}) {
    return _users.where('username', isEqualTo: username).get().then((value) =>
        value.docs.isNotEmpty ? User.fromJson(value.docs.first.data()) : null);
  }
}

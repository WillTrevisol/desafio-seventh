// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
part 'user_manager_store.g.dart';

class UserManager = _UserManagerBase with _$UserManager;

abstract class _UserManagerBase with Store {

  late SharedPreferences sharedPreferences;

  _UserManagerBase() {
    SharedPreferences.getInstance().then(
      (value) => sharedPreferences = value,
    );
  }
  
  @observable
  User? user;

  @action
  void setUser(User value) {
    user = value;
    final userJson = jsonEncode(value);
    sharedPreferences.setString('user', userJson);
  }

  @action
  Future<void> getUser() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final userJson = sharedPreferences.getString('user');
    if (userJson != null) {
      final jsonDecoded = jsonDecode(userJson);
      user = User.fromJson(jsonDecoded);
    }
  }

  @action
  Future<void> removeUser() async {
    await sharedPreferences.remove('user');
    user = null;
  }
}
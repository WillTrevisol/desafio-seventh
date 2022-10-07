// ignore_for_file: library_private_types_in_public_api

import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../repository/login.dart';
import 'user_manager_store.dart';
part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  

  @observable
  String userName = '';

  @observable
  String password = '';

  @observable
  bool obscureText = true;

  @observable
  bool loading = false;

  @observable
  dynamic error;

  @observable
  bool filledFields = false;

  @computed
  bool get isFieldsFilled {
    if (password.isNotEmpty && userName.isNotEmpty) {
      return true;
    }

    return false;
  }

  @action
  void setUserName(String value) => userName = value.trim();

  @action
  void setPassword(String value) => password = value.trim();

  @action
  void setLoading(bool value) => loading = value;

  @action 
  void setError(dynamic value) => error = value;

  @action
  void setObscureText(bool value) => obscureText = value;

  Future<void> login() async {
    setLoading(true);
    setError(null);
    try {
      
      final response = await LoginRepository().login(userName: userName, password: password);

      if (response != null) {
        GetIt.I.get<UserManager>().setUser(response);
      }

    } catch (e) {
      setError(e);
    }
    setLoading(false);
  }

  void logout() {
    GetIt.I.get<UserManager>().removeUser();
  }
}
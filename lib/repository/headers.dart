import 'package:get_it/get_it.dart';

import '../stores/user_manager_store.dart';

class Headers {

  Map<String, String> defaultHeader() {
    Map<String, String> header = {
      "Content-Type" : "application/json",
    };

    if (GetIt.I.get<UserManager>().user != null) {
      header["X-Access-Token"] = GetIt.I.get<UserManager>().user?.token as String;
    }

    return header;
  }

}
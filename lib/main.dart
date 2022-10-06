import 'package:desafio_seventh/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'screens/login/login_screen.dart';
import 'stores/login_store.dart';
import 'stores/user_manager_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _setupInstances();
  await GetIt.I.get<UserManager>().getUser();
  runApp(const Seventh());
}

void _setupInstances() {
  GetIt.I.registerSingleton(UserManager());
  GetIt.I.registerSingleton(LoginStore());
}

Widget _getFirstPage() {

  if (GetIt.I.get<UserManager>().user != null) {
    return const HomeScreen();
  } 
  
  return const LoginScreen();
}

class Seventh extends StatelessWidget {
  const Seventh({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seventh',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _getFirstPage(),
    );
  }
}
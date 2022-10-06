import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';

import '../../stores/login_store.dart';
import '../../widgets/custom_button.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginStore loginController = GetIt.I.get<LoginStore>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        color: Colors.blue,
        alignment: Alignment.center,
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 22),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18)
          ),
          elevation: 12,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 28),
            child: Observer(
              builder: (_) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget> [
                    const Text(
                      'LOGIN',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 22),
                    const Text('Nome de usuário:'),
                    const SizedBox(height: 8),
                    TextField(
                      enabled: !loginController.loading,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        hintText: 'joao-silva',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: loginController.setUserName,
                    ),
                    const SizedBox(height: 16),
                    const Text('Senha:'),
                    const SizedBox(height: 8),
                    TextField(
                      enabled: !loginController.loading,
                      obscureText: loginController.obscureText,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        isDense: true,
                        hintText: '*********',
                        suffixIcon: GestureDetector(
                          child: Icon(
                            loginController.obscureText 
                            ? FontAwesomeIcons.solidEye 
                            : FontAwesomeIcons.solidEyeSlash
                          ),
                          onTap: () => loginController.setObscureText(!loginController.obscureText),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: loginController.setPassword,
                    ),
                    const SizedBox(height: 22),
                    if (loginController.error != null) 
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(bottom: 22),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.red,
                        ),
                        child: Center(
                          child: Text(
                            loginController.error,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    CustomButton(
                      widget: loginController.loading 
                      ? const CircularProgressIndicator.adaptive(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                          backgroundColor: Colors.white,
                        )
                      : const Text('ENTRAR'),
                      onPressed: loginController.isFieldsFilled 
                      ? () async {
                        await loginController.login().then(
                          (_) => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => const HomeScreen())
                          ),
                        );
                      }
                      : null,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
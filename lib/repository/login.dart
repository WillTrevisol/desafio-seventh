import 'dart:convert';

import 'package:desafio_seventh/repository/headers.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class LoginRepository {

  Future<User?> login({required String userName, required String password}) async {

    final jsonEncoded = jsonEncode({"username" : userName,"password" : password});
    
    try {
      final response = await http.post(
        Uri.parse('http://mobiletest.seventh.com.br/login'),
        headers: Headers().defaultHeader(),
        body: jsonEncoded,
      );

      final responseDecoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return User(
          userName: userName,
          token: responseDecoded['token'],
        );
      }

      if (response.statusCode == 401) {
        return Future.error('Usuário ou senha incorreto.');
      }


      return Future.error('Falha ao realizar login.');

    } catch (e) {
      return Future.error('Falha ao realizar login.');
    }
  }
}
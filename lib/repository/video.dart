import 'dart:convert';

import 'package:http/http.dart' as http;

import 'headers.dart';

class VideoRepository {

  Future<String?> networkVideo() async {

    try {

      final response = await http.get(
        Uri.parse('http://mobiletest.seventh.com.br/video/bunny.mp4'),
        headers: Headers().defaultHeader(),
      );

      final jsonDecoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return jsonDecoded['url'];
      }

      return Future.error(jsonDecoded['message']);

    } catch (e) {
      return Future.error('Falha ao obter video.');
    }

  }
}
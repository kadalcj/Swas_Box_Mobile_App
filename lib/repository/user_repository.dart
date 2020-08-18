import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bank_sampah_mobile/model/user.dart';

class UserRepository {
  final uri = 'http://bank-sampah-api.herokuapp.com/api/';

  // Login
  Future<User> postLogin(String email, String password) async {
    Map<String, dynamic> body = {
      'email': email,
      'password': password
    };

    final response = await http.Client().post(
      Uri.encodeFull(uri + 'login'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: body,
    );

    if (response.statusCode != 200) {
      throw Exception();
    }

    return parsedJson(response.body);
  }

  // Parsing Response to Json
  User parsedJson(final response) {
    final jsonDecoded = json.decode(response);
    final jsonUser = jsonDecoded['data'];

    return User.fromJson(jsonUser);
  }
}
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bank_sampah_mobile/model/user.dart';

class UserRepository {
  final uri = 'http://bank-sampah-api.herokuapp.com/api/';

  // Login
  Future<User> postLogin(String email, String password) async {
    Map<String, dynamic> body = {
      'email': email,
      'password': password,
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
    final user = json.decode(response.body);

    return User.fromJson(user);
  }

  // Register
  Future<User> postRegister(String firstName, String lastName, String contact,
      String email, String password) async {
    Map<String, dynamic> body = {
      'firstName': firstName,
      'lastName': lastName,
      'contact': contact,
      'email': email,
      'password': password,
    };

    final response = await http.Client().post(
      Uri.encodeFull(uri + 'register'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: body,
    );

    if (response.statusCode != 201) {
      throw Exception();
    }

    return User.fromJson(json.decode(response.body.toString()));
  }

  // Get User by Id
  Future<User> postUserId(String userId) async {
    final response = await http.Client().post(
      uri + 'user/' + userId,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    if (response.statusCode != 200) {
      throw Exception();
    }

    return User.fromJson(json.decode(response.body));
  }
}

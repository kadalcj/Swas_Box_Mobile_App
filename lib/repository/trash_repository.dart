import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bank_sampah_mobile/model/trash.dart';
import 'package:bank_sampah_mobile/model/user.dart';

class TrashRepository {
  final uri = 'http://bank-sampah-api.herokuapp.com/api/';

  // Get User Trash
  Future<Trash> getTrash() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final userId = _prefs.getString('_id');

    final response = await http.Client().get(uri + 'trash/' + userId);

    if (response.statusCode != 200) {
      throw Exception();
    }

    return Trash.fromJson(json.decode(response.body));
  }

  Future<User> postTrash(
      String userId, String isCan, String poin, String trashName) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'isCan': isCan,
      'poin': poin,
      'name': trashName,
    };

    final response = await http.Client().post(
      Uri.encodeFull(uri + 'trash'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: body,
    );

    if (response.statusCode != 201) {
      throw Exception();
    }

    return User.fromJson(json.decode(response.body));
  }
}

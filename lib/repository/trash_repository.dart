import 'dart:convert';
import 'package:bank_sampah_mobile/model/trash.dart';
import 'package:http/http.dart' as http;

class TrashRepository {
  final uri = 'http://bank-sampah-api.herokuapp.com/api/';

  // Get User Trash
  Future<Trash> getTrash() async {
    final response =
        await http.Client().get(uri + 'trash/5f43d728962eca00170bd2f6');

    if (response.statusCode != 200) {
      throw Exception();
    }

    return Trash.fromJson(json.decode(response.body));
  }
}

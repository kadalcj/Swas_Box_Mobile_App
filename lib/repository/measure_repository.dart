import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bank_sampah_mobile/model/measure.dart';

class MeasureRepository {
  // final uri = 'http://192.168.43.110:5000/';

  // Let Rasp get the BG
  Future takeBackground(String uri) async {
    final response = await http.Client().get(uri + 'takeBg');

    if (response.statusCode != 200) {
      throw Exception();
    }

    return response.body;
  }

  // Measure Object
  Future<Measure> getMeasure(String uri) async {
    final response = await http.get(uri + 'measure-object');

    if (response.statusCode != 200) {
      throw Exception();
    }

    return Measure.fromJson(json.decode(response.body));
  }
}

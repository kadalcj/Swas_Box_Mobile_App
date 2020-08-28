import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bank_sampah_mobile/model/reward.dart';
import 'package:bank_sampah_mobile/model/user.dart';

class RewardRepository {
  final uri = 'http://bank-sampah-api.herokuapp.com/api/';

  // Get Reward
  Future<Reward> getReward() async {
    final response = await http.Client().get(uri + 'reward');

    if (response.statusCode != 200) {
      throw Exception();
    }

    return Reward.fromJson(json.decode(response.body));
  }

  // Post Invoice
  Future<User> postInvoice(String userId, String rewardId, String totalItem) async {
    Map<String, dynamic> body = {
      'userId': userId,
      'rewardId': rewardId,
      'totalItem': totalItem,
    };

    final response = await http.Client().post(
      Uri.encodeFull(uri + 'invoice'),
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

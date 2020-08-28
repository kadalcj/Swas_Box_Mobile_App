class Reward {
  List<Results> results;

  Reward({
    this.results,
  });

  Reward.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      results = new List<Results>();

      json['data'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }
}

class Results {
  String id;
  String name;
  int reqPoin;
  int stock;

  Results({
    this.id,
    this.name,
    this.reqPoin,
    this.stock,
  });

  Results.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    reqPoin = json['req_poin'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['_id'] = this.id;
    data['name'] = this.name;
    data['req_poin'] = this.reqPoin;
    data['stock'] = this.stock;

    return data;
  }
}

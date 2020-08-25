class Trash {
  List<Results> results;

  Trash({
    this.results,
  });

  Trash.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      results = new List<Results>();

      json['data'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }
}

class Results {
  String name;
  int poin;
  String timestamp;

  Results({
    this.name,
    this.poin,
    this.timestamp,
  });

  Results.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    poin = json['poin'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = this.name;
    data['poin'] = this.poin;
    data['timestamp'] = this.timestamp;

    return data;
  }
}

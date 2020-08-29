class Measure {
  Results results;

  Measure({
    this.results,
  });

  Measure.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      results = new Results();

      results = Results.fromJson(json['data']);
    }
  }
}

class Results {
  bool isCan;
  double height;

  Results({
    this.isCan,
    this.height,
  });

  Results.fromJson(Map<String, dynamic> json) {
    isCan = json['isCan'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['isCan'] = this.isCan;
    data['height'] = this.height;

    return data;
  }
}

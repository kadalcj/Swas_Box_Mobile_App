class User {
  Results results;

  User({
    this.results,
  });

  User.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      results = new Results();

      results = Results.fromJson(json['data']);
    }
  }
}

class Results {
  String id;
  String firstName;
  String lastName;
  String contact;
  String email;
  int poin;

  Results({
    this.id,
    this.firstName,
    this.lastName,
    this.contact,
    this.email,
    this.poin,
  });

  Results.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    contact = json['contact'];
    email = json['email'];
    poin = json['poin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['_id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['contact'] = this.contact;
    data['email'] = this.email;
    data['poin'] = this.poin;

    return data;
  }
}

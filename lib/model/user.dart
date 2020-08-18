class User {
  final firstName;
  final lastName;
  final contact;
  final email;
  final poin;

  User(this.firstName, this.lastName, this.contact, this.email, this.poin);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['firstName'],
      json['lastName'],
      json['contact'],
      json['email'],
      json['poin'],
    );
  }
}
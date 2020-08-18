class User {
  final String firstName;
  final String lastName;
  final String contact;
  final String email;
  final String poin;

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
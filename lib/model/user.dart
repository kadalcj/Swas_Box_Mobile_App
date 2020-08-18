class User {
<<<<<<< HEAD
  final firstName;
  final lastName;
  final contact;
  final email;
  final poin;
=======
  final String firstName;
  final String lastName;
  final String contact;
  final String email;
  final String poin;
>>>>>>> a734c6c034472724fe0f0deff844e6101da1ce11

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
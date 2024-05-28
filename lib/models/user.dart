class User {
  final String uid;
  final String email;
  final String firstName;
  final String lastName;

  User({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  Map<String, dynamic> toMap() => {
    'uid': uid,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
  };
}
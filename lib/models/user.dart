class User {
  final String uid;
  final String email;
  final String name;
  final String phone;

  User({
    required this.uid,
    required this.email,
    required this.name,
    required this.phone,
  });

  Map<String, dynamic> toMap() => {
    'uid': uid,
    'email': email,
    'name': name,
    'phone': phone,
  };
}
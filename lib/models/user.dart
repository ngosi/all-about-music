import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final List<String> following;

  User({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.following,
  });

  Map<String, dynamic> toMap() => {
    'uid': uid,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'following': following,
    'timestamp': FieldValue.serverTimestamp(),
  };
}
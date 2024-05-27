import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:all_about_music/models/user.dart' as model;

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<String> signUp({
  required String email,
  required String password,
  required String name,
  required String phone,
}) async {
  try {
    if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty || phone.isNotEmpty) {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      model.User user = model.User(
        uid: cred.user!.uid,
        email: email,
        name: name,
        phone: phone,
      );

      await _firestore.collection('users').doc(cred.user!.uid).set(user.toMap());
      return 'success';
    }
  } on FirebaseAuthException catch(err) {
    // switch (err.code) {
    //   case 'invalid-email':
    //     return 'The email is badly formatted';
    //   case 'weak-password':
    //     return 'Password should be at least 6 characters';
    // }
    return err.toString();
  } catch (err) {
    return err.toString();
  }
  return 'fields empty';
}

Future<String> login({
  required String email,
  required String password,
}) async {
  try {
    if (email.isNotEmpty && password.isNotEmpty) {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'success';
    }
    return 'Must input both fields';
  } on FirebaseAuthException catch (err) {
    // switch (err.code) {
    //   case 'invalid-email':
    //     return 'The email is badly formatted';
    //   case 'weak-password':
    //     return 'Password should be at least 6 characters';
    //   case 'user-not-found':
    //     return 'User not found';
    //   case 'wrong-password':
    //     return 'Wrong password';
    return err.toString();
  } catch (err) {
    return err.toString();
  }
}

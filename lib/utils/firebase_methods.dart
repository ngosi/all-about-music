import 'package:all_about_music/models/artist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:all_about_music/models/user.dart' as model;

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<String> signUp({
  required String email,
  required String password,
  required String firstName,
  required String lastName,
}) async {
  try {
    if (email.isNotEmpty || password.isNotEmpty || firstName.isNotEmpty || lastName.isNotEmpty) {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      cred.user!.updateDisplayName('$firstName $lastName');
      model.User user = model.User(
        uid: cred.user!.uid,
        email: email,
        firstName: firstName,
        lastName: lastName,
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
  return 'empty fields';
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
    return 'empty fields';
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

Future<String> artistSignup({
  required String stageName,
  required String bio,
  required String country,
  String? state,
  String? city,
}) async {
  try {
    if (stageName.isNotEmpty && bio.isNotEmpty && country.isNotEmpty) {
      Artist artist = Artist(
        stageName: stageName,
        bio: bio,
        country: country,
        state: state,
        city: city,
      );

      await _firestore.collection('artists').doc(_auth.currentUser!.uid).set(artist.toMap());
      return 'success';
    }
    return 'empty fields';
  } catch (err) {
    return err.toString();
  }
}

Future<bool> isArtist() async {
  DocumentSnapshot snap = await FirebaseFirestore.instance.collection('artists').doc(FirebaseAuth.instance.currentUser!.uid).get();
  return snap.exists;
}
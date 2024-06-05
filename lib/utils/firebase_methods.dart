import 'dart:typed_data';

import 'package:all_about_music/models/music.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import 'package:all_about_music/models/user.dart' as model;
import 'package:all_about_music/models/artist.dart';



final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseStorage _storage = FirebaseStorage.instance;

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
        following: [],
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
  required String? state,
  required String? city,
  required Uint8List? bannerImage,
  required Uint8List? cardImage,
  String? followerCount,
}) async {
  try {
    if (stageName.isNotEmpty && bio.isNotEmpty && country.isNotEmpty && (followerCount == null || int.tryParse(followerCount) != null)) {
      String? bannerUrl = bannerImage != null ? await uploadFile('banners', bannerImage) : null;
      String? cardUrl = cardImage != null ? await uploadFile('cards', cardImage) : null;
      Artist artist = Artist(
        stageName: stageName,
        bio: bio,
        country: country,
        state: state,
        city: city,
        bannerUrl: bannerUrl,
        cardUrl: cardUrl,
        demos: [],
        followers: [],
        followerCount: int.parse(followerCount!),
        messages: [],
      );

      await _firestore.collection('artists').doc(_auth.currentUser!.uid).set(artist.toMap());
      return 'success';
    }
    return 'empty fields or invalid followersCount';
  } catch (err) {
    return err.toString();
  }
}

Future<String> uploadDemo({
  required String title,
  required String author,
  required Uint8List? demo,
  required Uint8List? cover,
  String? votesCount,
}) async {
  try {
    if (title.isNotEmpty && author.isNotEmpty && demo != null && (votesCount == null || int.tryParse(votesCount) != null)) {
      String songId = const Uuid().v1();
      String songUrl = await uploadSong('songs', demo, songId);
      String? coverUrl = cover != null ? await uploadSong('covers', cover, songId) : null;
      Music music = Music(
        songId: songId,
        uid: _auth.currentUser!.uid,
        title: title,
        author: author,
        songUrl: songUrl,
        coverUrl: coverUrl,
        votes: [],
        votesCount: int.parse(votesCount!),
      );
      _firestore.collection('demos').doc(songId).set(music.toMap());
      _firestore.collection('artists').doc(_auth.currentUser!.uid).update({
        'demos': FieldValue.arrayUnion([songId]),
      });
      return 'success';
    }
    return 'song, cover art, title, and author required\ninvalid votesCount';
  } catch (err) {
    return err.toString();
  }
}

Future<String> uploadFile(String childName, Uint8List file) async {
  Reference ref = _storage.ref().child(childName).child(_auth.currentUser!.uid);
  TaskSnapshot snap = await ref.putData(file);
  return await snap.ref.getDownloadURL();
}

Future<String> uploadSong(String childName, Uint8List file, String songId) async {
  Reference ref = _storage.ref().child(childName).child(_auth.currentUser!.uid).child(songId);
  TaskSnapshot snap = await ref.putData(file);
  return await snap.ref.getDownloadURL();
}

Future<bool> isArtist() async {
  DocumentSnapshot snap = await FirebaseFirestore.instance.collection('artists').doc(FirebaseAuth.instance.currentUser!.uid).get();
  return snap.exists;
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Music {
  final String songId;
  final String uid;
  final String title;
  final String author;
  final String songUrl;
  final String? coverUrl;
  final List<String> votes;
  final int votesCount;

  Music({
    required this.songId,
    required this.uid,
    required this.title,
    required this.author,
    required this.songUrl,
    required this.coverUrl,
    required this.votes,
    required this.votesCount,
  });

  Map<String, dynamic> toMap() => {
    'songId': songId,
    'uid': uid,
    'title': title,
    'author': author,
    'songUrl': songUrl,
    'coverUrl': coverUrl,
    'votes': votes,
    'votesCount': votesCount,
    'timestamp': FieldValue.serverTimestamp(),
  };
}
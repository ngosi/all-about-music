import 'package:cloud_firestore/cloud_firestore.dart';

class Music {
  final String songId;
  final String uid;
  final String title;
  final String description;
  final String author;
  final String songUrl;
  final String? coverUrl;
  final List<String> votes;
  final int votesCount;

  Music({
    required this.songId,
    required this.uid,
    required this.title,
    required this.description,
    required this.author,
    required this.songUrl,
    required this.coverUrl,
    required this.votes,
    required this.votesCount,
  });

  factory Music.fromMap(Map<String, dynamic> data) {
    return Music(
      songId: data['songId'],
      uid: data['uid'],
      title: data['title'],
      description: data['description'],
      author: data['author'],
      songUrl: data['songUrl'],
      coverUrl: data['coverUrl'],
      votes: List<String>.from(data['votes']),
      votesCount: data['votesCount'],
    );
  }

  Map<String, dynamic> toMap() => {
    'songId': songId,
    'uid': uid,
    'title': title,
    'description': description,
    'author': author,
    'songUrl': songUrl,
    'coverUrl': coverUrl,
    'votes': votes,
    'votesCount': votesCount,
    'timestamp': FieldValue.serverTimestamp(),
  };
}
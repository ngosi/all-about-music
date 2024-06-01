class Music {
  final String songId;
  final String uid;
  final String title;
  final String author;
  final String songUrl;
  final String? coverUrl;

  Music({
    required this.songId,
    required this.uid,
    required this.title,
    required this.author,
    required this.songUrl,
    required this.coverUrl
  });

  Map<String, dynamic> toMap() => {
    'songId': songId,
    'uid': uid,
    'title': title,
    'author': author,
    'songUrl': songUrl,
    'coverUrl': coverUrl,
  };
}
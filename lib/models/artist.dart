import 'package:cloud_firestore/cloud_firestore.dart';

class Artist {
  final String stageName;
  final String bio;
  final String country;
  final String? state;
  final String? city;
  final String? bannerUrl;
  final String? cardUrl;
  final List<String> demos;
  final List<String> followers;
  final int followerCount;
  final List messages;

  Artist({
    required this.stageName,
    required this.bio,
    required this.country,
    required this.state,
    required this.city,
    required this.bannerUrl,
    required this.cardUrl,
    required this.demos,
    required this.followers,
    required this.followerCount,
    required this.messages,
  });

  factory Artist.fromMap(Map<String, dynamic> data) {
    return Artist(
      stageName: data['stageName'],
      bio: data['bio'],
      country: data['country'],
      state: data['state'],
      city: data['city'],
      bannerUrl: data['bannerUrl'],
      cardUrl: data['cardUrl'],
      demos: List<String>.from(data['demos']),
      followers: List<String>.from(data['followers']),
      followerCount: data['followerCount'],
      messages: List<String>.from(data['messages']),
    );
  }

  Map<String, dynamic> toMap() => {
    'stageName': stageName,
    'bio': bio,
    'country': country,
    'state': state,
    'city': city,
    'bannerUrl': bannerUrl,
    'cardUrl': cardUrl,
    'demos': demos,
    'followers': followers,
    'followerCount': followerCount,
    'messages': messages,
    'timestamp': FieldValue.serverTimestamp(),
  };
}
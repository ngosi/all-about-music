class Artist {
  final String stageName;
  final String bio;
  final String country;
  final String? state;
  final String? city;
  final String? bannerUrl;
  final List<String> fans;
  final List messages;

  Artist({
    required this.stageName,
    required this.bio,
    required this.country,
    this.state,
    this.city,
    this.bannerUrl,
    required this.fans,
    required this.messages,
  });

  Map<String, dynamic> toMap() => {
    'stageName': stageName,
    'bio': bio,
    'country': country,
    'state': state,
    'city': city,
    'image': bannerUrl,
    'fans': fans,
    'messages': messages,
  };
}
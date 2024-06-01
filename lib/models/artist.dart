class Artist {
  final String stageName;
  final String bio;
  final String country;
  final String? state;
  final String? city;
  final String? bannerUrl;
  final List<String> demos;
  final List<String> fans;
  final List messages;

  Artist({
    required this.stageName,
    required this.bio,
    required this.country,
    required this.state,
    required this.city,
    required this.bannerUrl,
    required this.demos,
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
    'demos': demos,
    'fans': fans,
    'messages': messages,
  };
}
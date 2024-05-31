class Artist {
  final String stageName;
  final String bio;
  final String country;
  final String? state;
  final String? city;

  Artist({
    required this.stageName,
    required this.bio,
    required this.country,
    this.state,
    this.city,
  });

  Map<String, dynamic> toMap() => {
    'stageName': stageName,
    'bio': bio,
    'country': country,
    'state': state,
    'city': city,
  };
}
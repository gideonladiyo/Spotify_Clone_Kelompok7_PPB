class Artists {
  final String name;
  final int followers;
  final int popularity;
  final String imageUrl;

  Artists({
    required this.name,
    required this.followers,
    required this.popularity,
    required this.imageUrl,
  });

  factory Artists.fromMap(Map<String, String> map) {
    return Artists(
      name: map['name'] ?? '',
      followers: int.tryParse(map['followers'] ?? '0') ?? 0,
      popularity: int.tryParse(map['popularity'] ?? '0') ?? 0,
      imageUrl: map['image'] ?? '',
    );
  }
}

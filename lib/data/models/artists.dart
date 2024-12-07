class Artists {
  final String id;
  final String name;
  final int followers;
  final int popularity;
  final String imageUrl;

  Artists({
    required this.id,
    required this.name,
    required this.followers,
    required this.popularity,
    required this.imageUrl,
  });

  factory Artists.fromMap(Map<String, dynamic> map) {
    return Artists(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      followers: map['followers']?['total'] ?? 0,
      popularity: map['popularity'] ?? 0,
      imageUrl: (map['images'] != null && map['images'].isNotEmpty)
          ? map['images'][0]['url']
          : '',
    );
  }
}

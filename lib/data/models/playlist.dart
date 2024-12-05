class PlaylistModel {
  final String title;
  final String count;
  final String imageUrl;

  PlaylistModel({
    required this.title,
    required this.count,
    required this.imageUrl,
  });

  factory PlaylistModel.fromMap(Map<String, String> map) {
    return PlaylistModel(
      title: map['title'] ?? '',
      count: map['count'] ?? '',
      imageUrl: map['image'] ?? '',
    );
  }
}

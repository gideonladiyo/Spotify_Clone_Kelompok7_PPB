class PlaylistModel {
  final String id;
  final String? title;
  final String? count;
  final String? imageUrl;

  PlaylistModel({
    required this.id,
    required this.title,
    required this.count,
    required this.imageUrl,
  });

  // Factory constructor untuk memetakan data dari JSON
  factory PlaylistModel.fromMap(Map<String, dynamic> map) {
    return PlaylistModel(
      id: map['id'] ?? '',
      title: map['name'] ?? '',
      count: '${map['tracks']['total'] ?? 0} songs',  // Jumlah lagu
      imageUrl: map['images'][0]['url'] ?? '',  // URL gambar
    );
  }
}
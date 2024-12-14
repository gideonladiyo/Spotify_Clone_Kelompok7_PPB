class Users {
  final String userId;
  final String name;
  final String email;
  final String imageUrl;
  final int followers;

  Users({
    required this.userId,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.followers
  });

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
        userId: map['id'],
        name: map['display_name'],
        email: map['email'],
        imageUrl: map['images'][0]['url'],
      followers: map['followers']['total']
    );
  }
}
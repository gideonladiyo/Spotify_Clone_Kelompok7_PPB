import 'package:flutter/material.dart';

class Playlist extends StatelessWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final playlists = [
      {
        "title": "Liked Songs",
        "count": "128 songs",
        "image":
            "https://media.istockphoto.com/id/1357329323/id/foto/dengarkan-konsep-buku-audio-aplikasi-pemutar-musik-online-di-smartphone.jpg?s=612x612&w=0&k=20&c=eDbUzqVTNftf9LEXwz28lNaPODNJ_xr9izltfc09lG0="
      },
      {
        "title": "Happiers",
        "count": "45 songs",
        "image":
            "https://i.scdn.co/image/ab67616d0000b273ad0f80c4b39d4eaa426a89a4"
      },
      {
        "title": "Sadness",
        "count": "83 songs",
        "image":
            "https://i.scdn.co/image/ab67616d0000b27388b99a0bf2e68752268acb5c"
      },
      {
        "title": "Party",
        "count": "21 songs",
        "image":
            "https://i.scdn.co/image/ab67616d0000b27383d92f1189defa34863e5343"
      },
      {
        "title": "Birthday",
        "count": "10 songs",
        "image":
            "https://mir-s3-cdn-cf.behance.net/project_modules/1400_opt_1/cc2e0e126904701.61374423b03c3.jpg"
      },
      {
        "title": "Highschool",
        "count": "5 songs",
        "image":
            "https://tse1.mm.bing.net/th?id=OIP.kqlDMBl2lA-9PkwRq406lwHaLK&pid=Api&P=0&h=180"
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Playlist"),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3 / 4,
          ),
          itemCount: playlists.length,
          itemBuilder: (context, index) {
            final playlist = playlists[index];
            return PlaylistItem(
              title: playlist['title']!,
              count: playlist['count']!,
              imageUrl: playlist['image']!,
            );
          },
        ),
      ),
    );
  }
}

class PlaylistItem extends StatelessWidget {
  final String title;
  final String count;
  final String imageUrl;

  const PlaylistItem({
    Key? key,
    required this.title,
    required this.count,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          count,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}


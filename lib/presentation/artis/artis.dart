// import 'package:flutter/material.dart';
// import 'package:spotify_group7/design_system/styles/app_colors.dart';
// import 'package:spotify_group7/design_system/styles/padding_col.dart';
// import 'package:spotify_group7/design_system/styles/typograph_col.dart';
// import 'package:spotify_group7/design_system/widgets/song_card/custom_song_card.dart';
// import 'package:spotify_group7/design_system/widgets/song_card/song_with_artis.dart';
// import 'package:spotify_group7/presentation/music_player/music_player.dart';

// class Artis extends StatelessWidget {
//   const Artis({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.darkBG,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               height: 250,
//               padding: EdgeInsets.symmetric(vertical: 30),
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                     image: AssetImage("assets/images/tulus.png"),
//                     fit: BoxFit.cover),
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(50),
//                   bottomRight: Radius.circular(50),
//                 ),
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.arrow_back_ios),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   Row(
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {},
//                         style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.all<Color>(
//                               AppColors.darkBG),
//                         ),
//                         child: Text(
//                           "Follow",
//                           style: TextStyle(fontSize: 14),
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.more_vert),
//                         onPressed: () {},
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.symmetric(vertical: 10),
//               decoration: BoxDecoration(
//                 color: AppColors.secondaryColor,
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(50),
//                   bottomRight: Radius.circular(50),
//                 ),
//               ),
//               child: Column(
//                 children: [],
//               ),
//             ),

//             SizedBox(height: 10),

//             Container(
//               padding: EdgeInsets.symmetric(vertical: 15),
//               decoration: BoxDecoration(
//                 color: AppColors.darkBG,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.white.withOpacity(0.2),
//                     blurRadius: 3,
//                     offset: Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Find Friend Button
//                   Column(
//                     children: [
//                       Text("Followers", style: TextStyle(color: Colors.white)),
//                       SizedBox(height: 5),
//                       Text("12.7K",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20)),
//                     ],
//                   ),
//                   SizedBox(width: 100),
//                   // Share Button
//                   Column(
//                     children: [
//                       Text("Monthly listerners",
//                           style: TextStyle(color: Colors.white)),
//                       SizedBox(height: 5),
//                       Text("4.88M",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20)),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(height: 20),
//             Container(
//                 alignment: Alignment.centerLeft,
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 child: Text(
//                   "Albums",
//                   style: TypographCol.h1,
//                 )),
//             SizedBox(height: PaddingCol.md),
//             SizedBox(
//               height: 250, // Tinggi tetap untuk ListView horizontal
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 children: [
//                   CustomSongCard(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (BuildContext context) =>
//                                   const MusicPlayer(
//                                     trackId:
//                                         '4kMQVpke2L9tlWOINuAo07?si=93d305cb90914f44',
//                                   )));
//                     },
//                     id_song: 1,
//                     imagePath: "imagePath",
//                     title1: "Manusia",
//                     title2: "2022",
//                   ),
//                   CustomSongCard(
//                     onPressed: () {},
//                     id_song: 2,
//                     imagePath: "imagePath",
//                     title1: "Monokrom",
//                     title2: "2016",
//                   ),
//                   CustomSongCard(
//                     onPressed: () {},
//                     id_song: 3,
//                     imagePath: "imagePath",
//                     title1: "Gajah",
//                     title2: "2016",
//                   ),
//                   CustomSongCard(
//                     onPressed: () {},
//                     id_song: 4,
//                     imagePath: "imagePath",
//                     title1: "Title 4",
//                     title2: "Subtitle 4",
//                   ),
//                   CustomSongCard(
//                     onPressed: () {},
//                     id_song: 5,
//                     imagePath: "imagePath",
//                     title1: "Title 5",
//                     title2: "Subtitle 5",
//                   ),
//                 ],
//               ),
//             ),

//             // Mostly Played Section
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Song",
//                     style: TypographCol.h1,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 300,
//               child: ListView(
//                 shrinkWrap: true,
//                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                 children: [
//                   MusicTile(
//                     title: "Hati-hati Di Jalan",
//                     artist: "Tulus",
//                     imageUrl: "https://via.placeholder.com/50",
//                   ),
//                   MusicTile(
//                     title: "Diri",
//                     artist: "Tulus",
//                     imageUrl: "https://via.placeholder.com/50",
//                   ),
//                   MusicTile(
//                     title: "Sepatu",
//                     artist: "Tulus",
//                     imageUrl: "https://via.placeholder.com/50",
//                   ),
//                   MusicTile(
//                     title: "1000 Tahun Lamanya",
//                     artist: "Tulus",
//                     imageUrl: "https://via.placeholder.com/50",
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:spotify_group7/design_system/styles/app_colors.dart';
import 'package:spotify_group7/design_system/styles/padding_col.dart';
import 'package:spotify_group7/design_system/widgets/song_card/song_with_artis.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBG,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        elevation: 0,
        title: Center(
          child: Text("Profil", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 40, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Kelompok 7",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "kelompokpbp7@gmail.com",
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text("Followers", style: TextStyle(fontSize: 12)),
                          SizedBox(height: 5),
                          Text("5",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        ],
                      ),
                      SizedBox(width: 100),
                      Column(
                        children: [
                          Text("Following", style: TextStyle(fontSize: 12)),
                          SizedBox(height: 5),
                          Text("5",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            // Find Friend and Share Button
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: AppColors.darkBG,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.2),
                    blurRadius: 3,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Find Friend Button
                  Column(
                    children: [
                      Icon(Icons.person_add_alt_1, color: Colors.white),
                      SizedBox(height: 5),
                      Text("Find friend",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  SizedBox(width: 100),
                  // Share Button
                  Column(
                    children: [
                      Icon(Icons.share, color: Colors.white),
                      SizedBox(height: 5),
                      Text("Share", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20),

            // Mostly Played Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Mostly played",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 300,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                children: [
                  MusicTile(
                    title: "Dekat Di Hati",
                    artist: "RAN",
                    imageUrl: "https://via.placeholder.com/50",
                  ),
                  MusicTile(
                    title: "Bigger Than The Whole Sky",
                    artist: "Taylor Swift",
                    imageUrl: "https://via.placeholder.com/50",
                  ),
                  MusicTile(
                    title: "Matilda",
                    artist: "Harry Styles",
                    imageUrl: "https://via.placeholder.com/50",
                  ),
                  MusicTile(
                    title: "Matilda",
                    artist: "Harry Styles",
                    imageUrl: "https://via.placeholder.com/50",
                  ),
                  MusicTile(
                    title: "Matilda",
                    artist: "Harry Styles",
                    imageUrl: "https://via.placeholder.com/50",
                  ),
                  MusicTile(
                    title: "Matilda",
                    artist: "Harry Styles",
                    imageUrl: "https://via.placeholder.com/50",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for songs, artists, or albums...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                // Handle search input
              },
            ),
            SizedBox(height: 20),

            // Suggested Searches (Example Data)
            Text(
              'Suggested Searches',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: [
                Chip(label: Text('Miles Davis')),
                Chip(label: Text('Doxy')),
                Chip(label: Text('Jazz Remastered')),
                Chip(label: Text('Kind of Blue')),
              ],
            ),
            SizedBox(height: 20),

            // Search Results (Example Data)
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Replace with actual result count
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.music_note),
                    title: Text('Song Title $index'),
                    subtitle: Text('Artist Name'),
                    onTap: () {
                      // Handle tap on search result
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
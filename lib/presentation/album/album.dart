import 'package:flutter/material.dart';

import '../../data/models/album.dart';


class AlbumView extends StatefulWidget {
  final Albums album;
  const AlbumView({Key? key, required this.album}) : super(key: key);

  @override
  State<AlbumView> createState() => _AlbumViewState();
}

class _AlbumViewState extends State<AlbumView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

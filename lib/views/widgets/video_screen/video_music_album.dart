//Created by giangtpu on 26/05/2023.
//Giangbb Studio
//giangtpu@gmail.com

import 'package:flutter/material.dart';

class VideoMusicAlbum extends StatelessWidget {
  final String avatarUrl;

  const VideoMusicAlbum({Key? key, required this.avatarUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(11),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.grey,
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(avatarUrl),
                  fit: BoxFit.cover,
                ),
              ))
        ],
      ),
    );
  }
}

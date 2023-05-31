//Created by giangtpu on 26/05/2023.
//Giangbb Studio
//giangtpu@gmail.com

import 'package:flutter/material.dart';

class VideoCaption extends StatelessWidget {
  final String username;
  final String caption;
  final String song;

  const VideoCaption({
    Key? key,
    required this.username,
    required this.caption,
    required this.song,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            username,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            caption,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.music_note,
                size: 15,
                color: Colors.white,
              ),
              Text(
                song,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

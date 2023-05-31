//Created by giangtpu on 26/05/2023.
//Giangbb Studio
//giangtpu@gmail.com

import 'package:flutter/material.dart';

class VideoAvatarItem extends StatelessWidget {
  final String avatarUrl;
  final VoidCallback onTap;
  const VideoAvatarItem(
      {Key? key, required this.avatarUrl, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 60,
        height: 60,
        child: Stack(children: [
          Positioned(
            left: 5,
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(avatarUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

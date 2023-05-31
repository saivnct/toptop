//Created by giangtpu on 26/05/2023.
//Giangbb Studio
//giangtpu@gmail.com
import 'package:flutter/material.dart';

class VideoActionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const VideoActionButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Icon(
            icon,
            size: 40,
            color: iconColor,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}

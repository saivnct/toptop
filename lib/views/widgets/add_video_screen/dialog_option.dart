//Created by giangtpu on 25/05/2023.
//Giangbb Studio
//giangtpu@gmail.com

import 'package:flutter/material.dart';

class DialogOption extends StatelessWidget {
  const DialogOption({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(icon),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Text(
              text,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

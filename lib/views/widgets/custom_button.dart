//Created by giangtpu on 26/05/2023.
//Giangbb Studio
//giangtpu@gmail.com
import 'package:flutter/material.dart';
import 'package:toptop/utils/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.text, required this.onTap})
      : super(key: key);

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 190,
        height: 50,
        decoration: BoxDecoration(color: buttonColor),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

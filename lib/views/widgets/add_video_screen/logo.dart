import 'package:flutter/material.dart';
import 'package:toptop/utils/colors.dart';
import 'package:toptop/utils/constant.dart';

const logoSize = 60.0;

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        Text(
          Constants.appName,
          style: TextStyle(
            fontSize: logoSize,
            color: textColor,
            fontWeight: FontWeight.w900,
          ),
        ),
        Positioned(
          left: -3,
          top: -1.5,
          child: Text(
            Constants.appName,
            style: TextStyle(
              fontSize: logoSize,
              color: Color.fromARGB(
                255,
                32,
                211,
                234,
              ),
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Positioned(
          right: -3,
          bottom: -1.5,
          child: Text(
            Constants.appName,
            style: TextStyle(
              fontSize: logoSize,
              color: Color.fromARGB(
                255,
                250,
                45,
                108,
              ),
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Positioned(
          child: Text(
            Constants.appName,
            style: TextStyle(
              fontSize: logoSize,
              color: textColor,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}

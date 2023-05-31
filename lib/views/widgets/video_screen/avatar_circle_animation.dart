//Created by giangtpu on 26/05/2023.
//Giangbb Studio
//giangtpu@gmail.com
import 'package:flutter/material.dart';

class AvatarCircleAnimation extends StatefulWidget {
  final Widget child;
  const AvatarCircleAnimation({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _AvatarCircleAnimationState createState() => _AvatarCircleAnimationState();
}

class _AvatarCircleAnimationState extends State<AvatarCircleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 5000,
      ),
    );
    controller.forward();
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(controller),
      child: widget.child,
    );
  }
}

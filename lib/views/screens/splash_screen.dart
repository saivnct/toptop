//Created by giangtpu on 25/05/2023.
//Giangbb Studio
//giangtpu@gmail.com
import 'package:flutter/material.dart';
import 'package:toptop/views/widgets/custom_circular_progress_indicator.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Loading...'),
            SizedBox(height: 20),
            CustomCircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

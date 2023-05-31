//Created by giangtpu on 25/05/2023.
//Giangbb Studio
//giangtpu@gmail.com
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toptop/services/auth_service.dart';
import 'package:toptop/views/widgets/auth_button.dart';

class LogoutScreen extends StatelessWidget {
  LogoutScreen({Key? key}) : super(key: key);

  final AuthService authService = Get.find();

  void _logout() {
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: AuthButton(
          text: 'Logout',
          onTap: _logout,
        ),
      ),
    );
  }
}

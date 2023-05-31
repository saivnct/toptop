//Created by giangtpu on 25/05/2023.
//Giangbb Studio
//giangtpu@gmail.com

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toptop/services/auth_service.dart';
import 'package:toptop/utils/colors.dart';
import 'package:toptop/views/widgets/add_video_screen/logo.dart';
import 'package:toptop/views/widgets/auth_button.dart';
import 'package:toptop/views/widgets/auth_screen/user_image_picker.dart';
import 'package:toptop/views/widgets/custom_circular_progress_indicator.dart';
import 'package:toptop/views/widgets/custom_text_input_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthService authService = Get.find();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();

  File? _userImageFile;

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void _onSelectedImage(File imageFile) async {
    _userImageFile = imageFile;
  }

  void _register() async {
    setState(() {
      _isLoading = true;
    });

    bool res = await authService.registerUser(_usernameController.text,
        _emailController.text, _passwordController.text, _userImageFile);

    if (!res) {
      setState(() {
        _isLoading = false;
      });
    } else {
      Get.back();
    }
  }

  void _gotoLogin(BuildContext context) {
    Get.back();

    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => LoginScreen(),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(padding: EdgeInsets.only(top: 50)),
              const Logo(),
              // const Text(
              //   'Register',
              //   style: TextStyle(
              //     fontSize: 16,
              //     fontWeight: FontWeight.w700,
              //   ),
              // ),
              const SizedBox(
                height: 25,
              ),
              UserImagePicker(onSelectedImage: _onSelectedImage),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextInputField(
                  controller: _usernameController,
                  labelText: 'Username',
                  icon: Icons.person,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextInputField(
                  controller: _emailController,
                  labelText: 'Email',
                  icon: Icons.email,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextInputField(
                  controller: _passwordController,
                  labelText: 'Password',
                  icon: Icons.lock,
                  isObscure: true,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              _isLoading
                  ? const CustomCircularProgressIndicator()
                  : AuthButton(
                      text: 'Register',
                      onTap: _register,
                    ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  InkWell(
                    onTap: () => _gotoLogin(context),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 20, color: buttonColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

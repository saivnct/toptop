//Created by giangtpu on 25/05/2023.
//Giangbb Studio
//giangtpu@gmail.com

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toptop/services/auth_service.dart';
import 'package:toptop/utils/colors.dart';
import 'package:toptop/views/screens/auth/signup_screen.dart';
import 'package:toptop/views/widgets/add_video_screen/logo.dart';
import 'package:toptop/views/widgets/auth_button.dart';
import 'package:toptop/views/widgets/custom_circular_progress_indicator.dart';
import 'package:toptop/views/widgets/custom_text_input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService authService = Get.find();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    bool res = await authService.loginUser(
      _emailController.text,
      _passwordController.text,
    );

    if (!res) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _gotoSignup(BuildContext context) {
    Get.to(() => const SignupScreen());

    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => SignupScreen(),
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
              //   'Login',
              //   style: TextStyle(
              //     fontSize: 16,
              //     fontWeight: FontWeight.w700,
              //   ),
              // ),
              const SizedBox(
                height: 38,
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
                height: 25,
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
                      text: 'Login',
                      onTap: _login,
                    ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account? ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  InkWell(
                    onTap: () => _gotoSignup(context),
                    child: Text(
                      'Register',
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

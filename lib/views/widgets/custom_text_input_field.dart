//Created by giangtpu on 25/05/2023.
//Giangbb Studio
//giangtpu@gmail.com

import 'package:flutter/material.dart';
import 'package:toptop/utils/colors.dart';

class CustomTextInputField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isObscure;
  final IconData icon;
  const CustomTextInputField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.isObscure = false,
    required this.icon,
  }) : super(key: key);

  @override
  State<CustomTextInputField> createState() => _CustomTextInputFieldState();
}

class _CustomTextInputFieldState extends State<CustomTextInputField> {
  final _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: textHighlightColor,
      focusNode: _focusNode,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: Icon(
          widget.icon,
          color: _isFocused ? textHighlightColor : textColor,
        ),
        labelStyle: TextStyle(
          fontSize: 20,
          color: _isFocused ? textHighlightColor : textColor,
        ),
        hintStyle: const TextStyle(
          fontSize: 20,
          color: textColor,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: borderColor,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: borderColorHighlight!,
            )),
      ),
      obscureText: widget.isObscure,
      autocorrect: false,
      enableSuggestions: false,
    );
  }
}

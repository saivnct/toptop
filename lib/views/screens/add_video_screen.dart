//Created by giangtpu on 25/05/2023.
//Giangbb Studio
//giangtpu@gmail.com
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toptop/views/screens/confirm_screen.dart';
import 'package:toptop/views/widgets/add_video_screen/dialog_option.dart';
import 'package:toptop/views/widgets/custom_button.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({Key? key}) : super(key: key);

  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    Get.back();
    if (video != null) {
      Get.to(ConfirmScreen(
        videoFile: File(video.path),
        videoPath: video.path,
      ));
    }
  }

  showOptionsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          DialogOption(
            onPressed: () => pickVideo(ImageSource.gallery, context),
            text: 'Gallery',
            icon: Icons.image,
          ),
          DialogOption(
            onPressed: () => pickVideo(ImageSource.camera, context),
            text: 'Camera',
            icon: Icons.camera_alt,
          ),
          DialogOption(
            onPressed: () => Get.back(),
            text: 'Cancel',
            icon: Icons.cancel,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomButton(
          onTap: () => showOptionsDialog(context),
          text: 'Add Video',
        ),
      ),
    );
  }
}

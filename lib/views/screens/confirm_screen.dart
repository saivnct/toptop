//Created by giangtpu on 25/05/2023.
//Giangbb Studio
//giangtpu@gmail.com
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toptop/controllers/upload_video_controller.dart';
import 'package:toptop/views/widgets/custom_button.dart';
import 'package:toptop/views/widgets/custom_circular_progress_indicator.dart';
import 'package:toptop/views/widgets/custom_text_input_field.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  const ConfirmScreen({
    Key? key,
    required this.videoFile,
    required this.videoPath,
  }) : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;
  final TextEditingController _songController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();
  final UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize().then((value) {
      controller.play();
      controller.setVolume(1);
      controller.setLooping(true);
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    _songController.dispose();
    _captionController.dispose();
  }

  void _uploadVideo() async {
    FocusScope.of(context).unfocus();

    setState(() {
      _isLoading = true;
    });

    bool res = await uploadVideoController.uploadVideo(
      songName: _songController.text,
      caption: _captionController.text,
      videoPath: widget.videoPath,
    );

    setState(() {
      _isLoading = false;
    });

    if (res) {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: VideoPlayer(controller),
            ),
            const SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: CustomTextInputField(
                      controller: _songController,
                      labelText: 'Song Name',
                      icon: Icons.music_note,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: CustomTextInputField(
                      controller: _captionController,
                      labelText: 'Caption',
                      icon: Icons.closed_caption,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _isLoading
                      ? const CustomCircularProgressIndicator()
                      : CustomButton(text: 'Share!', onTap: _uploadVideo),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

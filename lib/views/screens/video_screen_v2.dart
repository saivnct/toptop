//Created by giangtpu on 26/05/2023.
//Giangbb Studio
//giangtpu@gmail.com

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toptop/services/auth_service.dart';
import 'package:toptop/services/video_service.dart';
import 'package:toptop/views/screens/comment_screen.dart';
import 'package:toptop/views/screens/profile_screen.dart';
import 'package:toptop/views/widgets/custom_circular_progress_indicator.dart';
import 'package:toptop/views/widgets/video_screen/avatar_circle_animation.dart';
import 'package:toptop/views/widgets/video_screen/video_action_button.dart';
import 'package:toptop/views/widgets/video_screen/video_avatar_item.dart';
import 'package:toptop/views/widgets/video_screen/video_caption.dart';
import 'package:toptop/views/widgets/video_screen/video_music_album.dart';
import 'package:toptop/views/widgets/video_screen/video_player_item.dart';

class VideoScreenV2 extends StatefulWidget {
  const VideoScreenV2({Key? key}) : super(key: key);

  @override
  State<VideoScreenV2> createState() => _VideoScreenV2State();
}

class _VideoScreenV2State extends State<VideoScreenV2> {
  final _pageController = PageController(initialPage: 0, viewportFraction: 1);
  final VideoService videoService = Get.find();
  final AuthService authService = Get.find();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_checkIfLastPageAndDownload);

    if (videoService.myVideoList.isEmpty) {
      videoService.fetchMore(10);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _checkIfLastPageAndDownload() async {
    bool isLastPage =
        videoService.currentVideoIndex >= videoService.myVideoList.length - 1;
    if (isLastPage) {
      videoService.fetchMore(10);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (!videoService.serviceReady.value) {
          return const Center(child: CustomCircularProgressIndicator());
        } else {
          return GestureDetector(
            onVerticalDragEnd: (DragEndDetails details) {
              if (details.velocity.pixelsPerSecond.dy < 0) {
                _checkIfLastPageAndDownload();
              }
            },
            child: PageView.builder(
              onPageChanged: (value) {
                videoService.updateViewIndex(value);
                _checkIfLastPageAndDownload();
              },
              itemCount: videoService.myVideoList.length,
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final data = videoService.myVideoList[index];
                return Stack(
                  children: [
                    VideoPlayerItem(
                      videoUrl: data.videoUrl,
                    ),
                    Column(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: VideoCaption(
                                  username: data.username,
                                  caption: data.caption,
                                  song: data.songName,
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                // margin: EdgeInsets.only(top: size.height / 3),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    VideoAvatarItem(
                                      avatarUrl: data.profilePhoto,
                                      onTap: () => Get.to(
                                          () => ProfileScreen(uid: data.uid)),
                                    ),
                                    const SizedBox(height: 36),
                                    VideoActionButton(
                                      text: data.likes.length.toString(),
                                      icon: Icons.favorite,
                                      iconColor: data.likes
                                              .contains(authService.myUser!.uid)
                                          ? Colors.red
                                          : Colors.white,
                                      onTap: () =>
                                          videoService.likeVideo(data.id),
                                    ),
                                    const SizedBox(height: 36),
                                    VideoActionButton(
                                      text: data.commentCount.toString(),
                                      icon: Icons.comment,
                                      iconColor: Colors.white,
                                      onTap: () => Get.to(CommentScreen(
                                        id: data.id,
                                      )),
                                    ),
                                    const SizedBox(height: 36),
                                    AvatarCircleAnimation(
                                      child: VideoMusicAlbum(
                                          avatarUrl: data.profilePhoto),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          );
        }
      }),
    );
  }
}

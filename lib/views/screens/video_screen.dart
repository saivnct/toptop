// //Created by giangtpu on 26/05/2023.
// //Giangbb Studio
// //giangtpu@gmail.com
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:toptop/services/auth_service.dart';
// import 'package:toptop/services/video_service.dart';
// import 'package:toptop/views/screens/comment_screen.dart';
// import 'package:toptop/views/widgets/video_screen/avatar_circle_animation.dart';
// import 'package:toptop/views/widgets/video_screen/video_action_button.dart';
// import 'package:toptop/views/widgets/video_screen/video_avatar_item.dart';
// import 'package:toptop/views/widgets/video_screen/video_caption.dart';
// import 'package:toptop/views/widgets/video_screen/video_music_album.dart';
// import 'package:toptop/views/widgets/video_screen/video_player_item.dart';
//
// class VideoScreen extends StatefulWidget {
//   VideoScreen({Key? key}) : super(key: key);
//
//   @override
//   State<VideoScreen> createState() => _VideoScreenState();
// }
//
// class _VideoScreenState extends State<VideoScreen> {
//   final pageController = PageController(initialPage: 0, viewportFraction: 1);
//
//   final VideoService videoService = Get.find();
//
//   final AuthService authService = Get.find();
//
//   @override
//   void dispose() {
//     super.dispose();
//     pageController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(() {
//         return PageView.builder(
//           onPageChanged: (value) {
//             // print(value);
//           },
//           itemCount: videoService.videoList.length,
//           controller: pageController,
//           scrollDirection: Axis.vertical,
//           itemBuilder: (context, index) {
//             final data = videoService.videoList[index];
//             return Stack(
//               children: [
//                 VideoPlayerItem(
//                   videoUrl: data.videoUrl,
//                 ),
//                 Column(
//                   children: [
//                     Expanded(
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Expanded(
//                             child: VideoCaption(
//                               username: data.username,
//                               caption: data.caption,
//                               song: data.songName,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 100,
//                             // margin: EdgeInsets.only(top: size.height / 3),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 VideoAvatarItem(
//                                   avatarUrl: data.profilePhoto,
//                                 ),
//                                 const SizedBox(height: 50),
//                                 VideoActionButton(
//                                   text: data.likes.length.toString(),
//                                   icon: Icons.favorite,
//                                   iconColor:
//                                       data.likes.contains(authService.user.uid)
//                                           ? Colors.red
//                                           : Colors.white,
//                                   onTap: () => videoService.likeVideo(data.id),
//                                 ),
//                                 const SizedBox(height: 50),
//                                 VideoActionButton(
//                                   text: data.commentCount.toString(),
//                                   icon: Icons.comment,
//                                   iconColor: Colors.white,
//                                   onTap: () => Get.to(CommentScreen(
//                                     id: data.id,
//                                   )),
//                                 ),
//                                 const SizedBox(height: 50),
//                                 AvatarCircleAnimation(
//                                   child: VideoMusicAlbum(
//                                       avatarUrl: data.profilePhoto),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                   ],
//                 ),
//               ],
//             );
//           },
//         );
//       }),
//     );
//   }
// }

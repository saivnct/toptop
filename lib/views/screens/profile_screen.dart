//Created by giangtpu on 30/05/2023.
//Giangbb Studio
//giangtpu@gmail.com
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toptop/controllers/profile_controller.dart';
import 'package:toptop/services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());
  final AuthService authService = Get.find();

  @override
  void initState() {
    super.initState();
    profileController.updateUserId(widget.uid);
  }

  @override
  void dispose() {
    profileController.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final size = MediaQuery.of(context).size;
      Widget avatar = Image.asset('assets/images/place-holder-avatar.png');
      if (profileController.profile != null) {
        avatar = CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: profileController.profile!.profilePhoto,
          height: 100,
          width: 100,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(
            Icons.error,
          ),
        );
      }

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black12,
          leading: const Icon(
            Icons.person_add_alt_1_outlined,
          ),
          actions: const [
            Icon(Icons.more_horiz),
          ],
          title: Text(
            profileController.profile?.name ?? "Unknown",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              width: size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: ClipOval(child: avatar),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            profileController.profile?.followings.length
                                    .toString() ??
                                '0',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Following',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        color: Colors.black54,
                        width: 1,
                        height: 15,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            profileController.profile?.followers.length
                                    .toString() ??
                                '0',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Followers',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        color: Colors.black54,
                        width: 1,
                        height: 15,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            profileController.totalLikes.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Likes',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 140,
                    height: 47,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                      ),
                    ),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          if (widget.uid == authService.myUser!.uid) {
                            profileController.release();
                            Get.back();
                            authService.signOut();
                          } else {
                            profileController.followUser();
                          }
                        },
                        child: Text(
                          widget.uid == authService.myUser!.uid
                              ? 'Sign Out'
                              : profileController.isFollowing
                                  ? 'Unfollow'
                                  : 'Follow',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // video list
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: profileController.videos.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 5,
                    ),
                    itemBuilder: (context, index) {
                      String thumbnail =
                          profileController.videos[index].thumbnail;
                      return CachedNetworkImage(
                        imageUrl: thumbnail,
                        fit: BoxFit.cover,
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

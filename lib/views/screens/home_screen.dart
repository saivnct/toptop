//Created by giangtpu on 25/05/2023.
//Giangbb Studio
//giangtpu@gmail.com
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toptop/services/auth_service.dart';
import 'package:toptop/utils/colors.dart';
import 'package:toptop/views/screens/add_video_screen.dart';
import 'package:toptop/views/screens/profile_screen.dart';
import 'package:toptop/views/screens/search_screen.dart';
import 'package:toptop/views/screens/video_screen_v2.dart';
import 'package:toptop/views/widgets/home_screen/center_tabbar_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIdx = 0;
  final AuthService authService = Get.find();

  List pages = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (authService.user == null) {
        return const Center(child: CircularProgressIndicator());
      } else {
        pages = [
          // VideoScreen(),
          const VideoScreenV2(),
          const SearchScreen(),
          const AddVideoScreen(),
          const Center(child: Text('Messages Screen')),
          ProfileScreen(uid: authService.user!.uid),
        ];

        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            onTap: (idx) {
              setState(() {
                pageIdx = idx;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: backgroundColor,
            selectedItemColor: buttonColor,
            unselectedItemColor: Colors.white,
            currentIndex: pageIdx,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search, size: 30),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: CenterTabbarIcon(),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message, size: 30),
                label: 'Messages',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 30),
                label: 'Profile',
              ),
            ],
          ),
          body: pages[pageIdx],
        );
      }
    });
  }
}

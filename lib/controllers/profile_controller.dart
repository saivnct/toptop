//Created by giangtpu on 30/05/2023.
//Giangbb Studio
//giangtpu@gmail.com
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:toptop/models/my_user.dart';
import 'package:toptop/models/video.dart';
import 'package:toptop/services/auth_service.dart';
import 'package:toptop/utils/constant.dart';
import 'package:toptop/utils/firebase.dart';
import 'package:toptop/utils/snack.dart';

class ProfileController extends GetxController {
  final Rx<MyUser?> _profile = Rx<MyUser?>(null);
  MyUser? get profile => _profile.value;
  var profileStreamSubscription;

  final Rx<List<Video>> _videos = Rx<List<Video>>([]);
  List<Video> get videos => _videos.value;
  var videoStreamSubscription;

  int get totalLikes {
    int likes = 0;
    for (var video in videos) {
      likes += video.likes.length;
    }
    return likes;
  }

  bool get isFollowing {
    AuthService authService = Get.find();
    var myUid = authService.myUser!.uid;
    if (profile != null && profile!.followers.contains(myUid)) {
      return true;
    }
    return false;
  }

  String _uid = "";

  release() {
    profileStreamSubscription?.cancel();
    videoStreamSubscription?.cancel();
  }

  updateUserId(String uid) {
    release();
    _uid = uid;
    getUserData();
  }

  getUserData() async {
    final profileStream = firestore
        .collection(Constants.collectionUsers)
        .doc(_uid)
        .snapshots()
        .map(
      (DocumentSnapshot document) {
        final user = MyUser.fromSnap(document);
        return user;
      },
    );

    profileStreamSubscription = profileStream.listen((data) {
      _profile.value = data;
    });

    final videosStream = firestore
        .collection(Constants.collectionVideos)
        .where(Video.fieldUid, isEqualTo: _uid)
        .snapshots()
        .map(
      (QuerySnapshot query) {
        List<Video> retValue = [];
        for (var element in query.docs) {
          Video video = Video.fromSnap(element);
          retValue.add(video);
        }
        return retValue;
      },
    );

    videoStreamSubscription = videosStream.listen((data) {
      _videos.value = data;
    });
  }

  followUser() async {
    if (profile == null) {
      return;
    }

    try {
      AuthService authService = Get.find();
      var myUid = authService.myUser!.uid;

      if (profile!.followers.contains(myUid)) {
        await firestore.collection(Constants.collectionUsers).doc(_uid).update({
          MyUser.fieldFollowers: FieldValue.arrayRemove([myUid])
        });

        await firestore
            .collection(Constants.collectionUsers)
            .doc(myUid)
            .update({
          MyUser.fieldFollowings: FieldValue.arrayRemove([_uid])
        });
      } else {
        await firestore.collection(Constants.collectionUsers).doc(_uid).update({
          MyUser.fieldFollowers: FieldValue.arrayUnion([myUid])
        });

        await firestore
            .collection(Constants.collectionUsers)
            .doc(myUid)
            .update({
          MyUser.fieldFollowings: FieldValue.arrayUnion([_uid]),
        });
      }
    } catch (e) {
      print(e);
      SnackNotify.showError('Error', 'Error While follow User');
    }
  }
}

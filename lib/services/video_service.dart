//Created by giangtpu on 26/05/2023.
//Giangbb Studio
//giangtpu@gmail.com
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:toptop/models/video.dart';
import 'package:toptop/services/auth_service.dart';
import 'package:toptop/utils/constant.dart';
import 'package:toptop/utils/firebase.dart';

class VideoService extends GetxService {
  // final Rx<List<Video>> _videoList = Rx<List<Video>>([]);
  // List<Video> get videoList => _videoList.value;

  final List<Video> myVideoList = <Video>[].obs;
  final Set<int> ids = <int>{};
  var serviceReady = false.obs;

  var currentVideoIndex = 0;
  var streamSubscription;
  var isFetching = false;

  // @override
  // void onInit() {
  //   super.onInit();
  //   _videoList.bindStream(
  //     firestore.collection(Constants.collectionVideos).snapshots().map(
  //       (QuerySnapshot query) {
  //         List<Video> retVal = [];
  //         for (var element in query.docs) {
  //           retVal.add(
  //             Video.fromSnap(element),
  //           );
  //         }
  //         // print('on update!!!!!!!!');
  //         return retVal;
  //       },
  //     ),
  //   );
  // }

  registerListener() async {
    // print('VideoService - registerListener');
    streamSubscription = firestore
        .collection(Constants.collectionVideos)
        .snapshots()
        .listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      // Process the changes in the snapshot
      snapshot.docChanges.forEach((change) {
        // Handle the change (added, modified, or removed document)
        if (change.type == DocumentChangeType.added) {
          // Document added
          // print('Document added: ${change.doc.data()}');
        } else if (change.type == DocumentChangeType.modified) {
          // Document modified
          // print('Document modified: ${change.doc.data()}');
          final video = Video.fromSnap(change.doc);
          final i = myVideoList.indexWhere((v) => v.id == video.id);
          if (i >= 0) {
            myVideoList[i] = video;
          }
        } else if (change.type == DocumentChangeType.removed) {
          // Document removed
          // print('Document removed: ${change.doc.data()}');
        }
      });
    });

    await fetchMore(10);
    serviceReady.value = true;
  }

  releaseListener() {
    // print('VideoService - releaseListener');
    streamSubscription?.cancel();
    myVideoList.clear();
    ids.clear();
    currentVideoIndex = 0;
    serviceReady.value = false;
  }

  updateViewIndex(index) {
    // print('updateViewIndex $index');
    currentVideoIndex = index;
  }

  likeVideo(String id) async {
    AuthService authService = Get.find();
    DocumentSnapshot doc =
        await firestore.collection(Constants.collectionVideos).doc(id).get();
    var uid = authService.myUser!.uid;
    if ((doc.data()! as dynamic)[Video.fieldLikes].contains(uid)) {
      await firestore.collection(Constants.collectionVideos).doc(id).update({
        Video.fieldLikes: FieldValue.arrayRemove([uid]),
      });
    } else {
      await firestore.collection(Constants.collectionVideos).doc(id).update({
        Video.fieldLikes: FieldValue.arrayUnion([uid]),
      });
    }
  }

  fetchMore(int limit) async {
    if (isFetching) {
      return;
    }
    print('fetchMore $limit');
    isFetching = true;
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection(Constants.collectionVideos).get();

      List<int> availableIds = <int>[];
      for (int i = 0; i < snapshot.size; i++) {
        if (!ids.contains(i)) {
          availableIds.add(i);
        }
      }

      if (availableIds.isEmpty) {
        throw Exception('No more videos');
      }

      availableIds.shuffle();

      final maxLim = limit < availableIds.length ? limit : availableIds.length;

      List<int> randomIds = availableIds.sublist(0, maxLim);

      final snap = await firestore
          .collection(Constants.collectionVideos)
          .where(Video.fieldRand, whereIn: randomIds)
          .get();

      if (snap.docs.isNotEmpty) {
        for (var element in snap.docs) {
          final video = Video.fromSnap(element);
          final i = myVideoList.indexWhere((v) => v.id == video.id);
          if (i < 0) {
            myVideoList.add(video);
            ids.add(video.rand);
          }
        }
      }
    } catch (e) {
      // print(e);
    }
    isFetching = false;
  }
}

//Created by giangtpu on 25/05/2023.
//Giangbb Studio
//giangtpu@gmail.com

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:toptop/models/video.dart';
import 'package:toptop/services/auth_service.dart';
import 'package:toptop/utils/constant.dart';
import 'package:toptop/utils/firebase.dart';
import 'package:toptop/utils/snack.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );
    return compressedVideo!.file;
  }

  Future<String> _uploadVideoToStorage(String videoId, String videoPath) async {
    Reference ref =
        firebaseStorage.ref().child(Constants.storageVideos).child(videoId);

    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> _uploadImageToStorage(String videoId, String videoPath) async {
    Reference ref =
        firebaseStorage.ref().child(Constants.storageThumnails).child(videoId);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // upload video
  Future<bool> uploadVideo({
    required String songName,
    required String caption,
    required String videoPath,
  }) async {
    try {
      AuthService authService = Get.find();
      String uid = authService.myUser!.uid;

      // get id
      var allDocs =
          await firestore.collection(Constants.collectionVideos).get();
      int len = allDocs.docs.length;
      String videoId = uuid.v4();
      String videoUrl = await _uploadVideoToStorage(videoId, videoPath);
      String thumbnail = await _uploadImageToStorage(videoId, videoPath);

      Video video = Video(
        username: authService.myUser!.name,
        uid: uid,
        id: videoId,
        rand: len,
        likes: [],
        commentCount: 0,
        shareCount: 0,
        songName: songName,
        caption: caption,
        videoUrl: videoUrl,
        profilePhoto: authService.myUser!.profilePhoto,
        thumbnail: thumbnail,
      );

      await firestore
          .collection(Constants.collectionVideos)
          .doc(videoId)
          .set(video.toJson());

      return true;
    } catch (e) {
      SnackNotify.showError('Error', 'Error Uploading Video');
    }

    return false;
  }
}

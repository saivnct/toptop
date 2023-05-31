//Created by giangtpu on 30/05/2023.
//Giangbb Studio
//giangtpu@gmail.com

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:toptop/models/comment.dart';
import 'package:toptop/models/video.dart';
import 'package:toptop/services/auth_service.dart';
import 'package:toptop/utils/constant.dart';
import 'package:toptop/utils/firebase.dart';
import 'package:toptop/utils/snack.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  List<Comment> get comments => _comments.value;
  var commentStreamSubscription;

  String _postId = "";

  updatePostId(String id) {
    release();
    _postId = id;
    getComment();
  }

  release() {
    commentStreamSubscription?.cancel();
  }

  getComment() async {
    final commentStream = firestore
        .collection(Constants.collectionVideos)
        .doc(_postId)
        .collection(Constants.collectionComments)
        .orderBy(Comment.fieldDatePublished, descending: false)
        .snapshots()
        .map(
      (QuerySnapshot query) {
        List<Comment> retValue = [];
        for (var element in query.docs) {
          retValue.add(Comment.fromSnap(element));
        }
        retValue.sort((a, b) => a.datePublished!.compareTo(b.datePublished!));
        return retValue;
      },
    );

    commentStreamSubscription = commentStream.listen((data) {
      _comments.value = data;
    });
  }

  postComment(String commentText) async {
    try {
      if (commentText.trim().isEmpty) {
        return;
      }

      if (_postId.isEmpty) {
        return;
      }
      AuthService authService = Get.find();

      String commentId = uuid.v4();

      Comment comment = Comment(
        username: authService.myUser!.name,
        comment: commentText.trim(),
        datePublished: DateTime.now(),
        likes: [],
        profilePhoto: authService.myUser!.profilePhoto,
        uid: authService.myUser!.uid,
        id: commentId,
      );

      await firestore
          .collection(Constants.collectionVideos)
          .doc(_postId)
          .collection(Constants.collectionComments)
          .doc(commentId)
          .set(comment.toJson());

      DocumentSnapshot doc = await firestore
          .collection(Constants.collectionVideos)
          .doc(_postId)
          .get();
      Video video = Video.fromSnap(doc);
      await firestore
          .collection(Constants.collectionVideos)
          .doc(_postId)
          .update({
        Video.fieldCommentCount: video.commentCount + 1,
      });
    } catch (e) {
      SnackNotify.showError('Error', 'Error While Commenting');
    }
  }

  likeComment(String commentId) async {
    try {
      AuthService authService = Get.find();
      var uid = authService.myUser!.uid;
      DocumentSnapshot doc = await firestore
          .collection(Constants.collectionVideos)
          .doc(_postId)
          .collection(Constants.collectionComments)
          .doc(commentId)
          .get();

      if (!doc.exists) {
        return;
      }

      final comment = Comment.fromSnap(doc);

      if (comment.likes.contains(uid)) {
        await firestore
            .collection(Constants.collectionVideos)
            .doc(_postId)
            .collection(Constants.collectionComments)
            .doc(commentId)
            .update({
          Comment.fieldLikes: FieldValue.arrayRemove([uid]),
        });
      } else {
        await firestore
            .collection(Constants.collectionVideos)
            .doc(_postId)
            .collection(Constants.collectionComments)
            .doc(commentId)
            .update({
          Comment.fieldLikes: FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e);
      SnackNotify.showError('Error', 'Error While Commenting');
    }
  }
}

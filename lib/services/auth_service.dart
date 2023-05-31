//Created by giangtpu on 25/05/2023.
//Giangbb Studio
//giangtpu@gmail.com

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:toptop/models/my_user.dart';
import 'package:toptop/services/video_service.dart';
import 'package:toptop/utils/constant.dart';
import 'package:toptop/utils/firebase.dart';
import 'package:toptop/utils/snack.dart';

class AuthService extends GetxService {
  final Rx<User?> _user = Rx<User?>(firebaseAuth.currentUser);
  User? get user => _user.value;
  MyUser? myUser = null.obs();

  @override
  void onReady() {
    super.onReady();
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _onUserUpdate); //whenever user changes, call this function
  }

  _onUserUpdate(User? user) async {
    VideoService videoService = Get.find();
    if (user == null) {
      // Get.offAll(() => LoginScreen());
      videoService.releaseListener();
    } else {
      try {
        final snap = await firestore
            .collection(Constants.collectionUsers)
            .doc(user.uid)
            .get();
        if (snap.exists) {
          myUser = MyUser.fromSnap(snap);
        }
      } catch (e) {
        print(e);
      }

      // Get.offAll(() => LogoutScreen());
      videoService.registerListener();
    }
  }

  // upload to firebase storage
  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child(Constants.storageAvatar)
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // registering the user
  Future<bool> registerUser(
      String username, String email, String password, File? image) async {
    if (username.trim().isEmpty) {
      SnackNotify.showError('Error Creating Account', 'Invalid username');
      return false;
    }

    if (email.isEmpty || !email.isEmail) {
      SnackNotify.showError('Error Creating Account', 'Invalid email');
      return false;
    }

    if (password.trim().isEmpty) {
      SnackNotify.showError('Error Creating Account', 'Invalid password');
      return false;
    }

    if (image == null) {
      SnackNotify.showError('Error Creating Account', 'Please chose avatar');
      return false;
    }

    try {
      // save out user to our ath and firebase firestore
      UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String downloadUrl = await _uploadToStorage(image);
      MyUser myUserTemp = MyUser(
        name: username,
        email: email,
        uid: cred.user!.uid,
        profilePhoto: downloadUrl,
        followers: [],
        followings: [],
      );
      await firestore
          .collection(Constants.collectionUsers)
          .doc(cred.user!.uid)
          .set(myUserTemp.toJson());

      myUser = myUserTemp;
      return true;
    } catch (e) {
      print(e);
      SnackNotify.showError('Error', 'Error Creating Account!');
    }

    return false;
  }

  Future<bool> loginUser(String email, String password) async {
    if (email.isEmpty || !email.isEmail || password.isEmpty) {
      SnackNotify.showError('Error', 'Invalid login information');
      return false;
    }

    try {
      final UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;
      if (user != null) {
        final snap = await firestore
            .collection(Constants.collectionUsers)
            .doc(user.uid)
            .get();
        if (snap.exists) {
          myUser = MyUser.fromSnap(snap);
          return true;
        }
      }
    } catch (e) {
      SnackNotify.showError('Error Login', e.toString());
    }

    return false;
  }

  void signOut() async {
    myUser = null;
    await firebaseAuth.signOut();
  }
}

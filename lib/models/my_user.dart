//Created by giangtpu on 25/05/2023.
//Giangbb Studio
//giangtpu@gmail.com
import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  String name;
  String profilePhoto;
  String email;
  String uid;
  List followers;
  List followings;

  static const fieldFollowers = 'followers';
  static const fieldFollowings = 'followings';

  MyUser({
    required this.name,
    required this.email,
    required this.uid,
    required this.profilePhoto,
    required this.followers,
    required this.followings,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "profilePhoto": profilePhoto,
        "followers": followers,
        "followings": followings,
        "email": email,
        "uid": uid,
      };

  static MyUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return MyUser(
      email: snapshot['email'],
      profilePhoto: snapshot['profilePhoto'],
      followers: snapshot['followers'],
      followings: snapshot['followings'],
      uid: snapshot['uid'],
      name: snapshot['name'],
    );
  }
}

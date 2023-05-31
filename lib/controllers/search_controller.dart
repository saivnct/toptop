//Created by giangtpu on 30/05/2023.
//Giangbb Studio
//giangtpu@gmail.com

import 'package:get/get.dart';
import 'package:toptop/models/my_user.dart';
import 'package:toptop/utils/firebase.dart';

class SearchController extends GetxController {
  final Rx<List<MyUser>> _searchedUsers = Rx<List<MyUser>>([]);

  List<MyUser> get searchedUsers => _searchedUsers.value;

  release() {
    _searchedUsers.value = [];
  }

  searchUser(String typedUser) async {
    final snap = await firestore
        .collection('users')
        // .where('name', isGreaterThanOrEqualTo: typedUser)
        .get();

    List<MyUser> retVal = [];
    if (snap.docs.isNotEmpty) {
      for (var element in snap.docs) {
        final user = MyUser.fromSnap(element);
        if (typedUser.isNotEmpty && RegExp(typedUser).hasMatch(user.name)) {
          retVal.add(user);
        }
      }
    }

    _searchedUsers.value = retVal;
  }
}

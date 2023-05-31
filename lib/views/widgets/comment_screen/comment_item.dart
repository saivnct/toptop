//Created by giangtpu on 30/05/2023.
//Giangbb Studio
//giangtpu@gmail.com

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:toptop/controllers/comment_controller.dart';
import 'package:toptop/models/comment.dart';
import 'package:toptop/services/auth_service.dart';

class CommentItem extends StatelessWidget {
  CommentItem({Key? key, required this.comment}) : super(key: key);

  final Comment comment;
  final CommentController commentController = Get.find();
  final AuthService authService = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.black,
        backgroundImage: NetworkImage(comment.profilePhoto),
      ),
      title: Row(
        children: [
          Text(
            "${comment.username}  ",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.red,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            comment.comment,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      subtitle: Row(
        children: [
          Text(
            timeago.format(
              comment.datePublished.toDate(),
            ),
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            '${comment.likes.length} likes',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          )
        ],
      ),
      trailing: InkWell(
        onTap: () => commentController.likeComment(comment.id),
        child: Icon(
          Icons.favorite,
          size: 25,
          color: comment.likes.contains(authService.myUser!.uid)
              ? Colors.red
              : Colors.white,
        ),
      ),
    );
  }
}

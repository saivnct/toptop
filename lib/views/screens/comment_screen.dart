//Created by giangtpu on 26/05/2023.
//Giangbb Studio
//giangtpu@gmail.com
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toptop/controllers/comment_controller.dart';
import 'package:toptop/services/auth_service.dart';
import 'package:toptop/utils/colors.dart';
import 'package:toptop/views/widgets/comment_screen/comment_item.dart';

class CommentScreen extends StatefulWidget {
  final String id;
  const CommentScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();

  final CommentController commentController = Get.put(CommentController());

  final AuthService authService = Get.find();

  void _postComment() {
    FocusScope.of(context).unfocus();
    commentController.postComment(_commentController.text);
    _commentController.clear();
  }

  @override
  void initState() {
    super.initState();
    commentController.updatePostId(widget.id);
  }

  @override
  void dispose() {
    _commentController.dispose();
    commentController.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: buttonColor,
        title: const Text('Comments'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return ListView.builder(
                    itemCount: commentController.comments.length,
                    itemBuilder: (context, index) {
                      final comment = commentController.comments[index];
                      return CommentItem(comment: comment);
                    });
              }),
            ),
            // const Divider(
            //   color: Colors.white,
            //   thickness: 1,
            // ),
            ListTile(
              title: TextFormField(
                controller: _commentController,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  labelText: 'Leave a comment',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              trailing: IconButton(
                onPressed: _postComment,
                icon: Icon(
                  Icons.send,
                  size: 50,
                  color: buttonColor,
                ),
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

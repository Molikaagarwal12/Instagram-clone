import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Pages/commentScreen.dart';
import 'package:instagram_clone/utils/pick_image.dart';
import 'package:instagram_clone/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/model.dart';
import '../resources/fireStore_method.dart';
import '../user_provider.dart';
import 'colors.dart';

class UserPost extends StatefulWidget {
  final snap;

  const UserPost({Key? key, required this.snap}) : super(key: key);

  @override
  State<UserPost> createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  bool favourite = false;
  int commentLn = 0;
  bool _isLoading = true;

  @override
  void initState() {
    fetchCommentLen();
    super.initState();
  }

  fetchCommentLen() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();

      commentLn = snap.docs.length;
    } catch (err) {
      showSnackBar(
        err.toString(),
        context,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(widget.snap['profImage']),
                              fit: BoxFit.fill,
                            ),
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.snap['userName'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: ListView(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shrinkWrap: true,
                              children: [
                                'Delete',
                              ].map(
                                (e) => InkWell(
                                  onTap: () async {
                                    FireStoreMethod()
                                        .deletePost(widget.snap['postId']);
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 16,
                                    ),
                                    child: Text(e),
                                  ),
                                ),
                              ).toList(),
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.more_vert),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onDoubleTap: () async {
                  FireStoreMethod().likePost(
                    widget.snap['postId'],
                    user.uid,
                    widget.snap['likes'],
                  );
                  setState(() {
                    favourite = true;
                  });
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 400,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          image: DecorationImage(
                            image: NetworkImage(widget.snap['postUrl']),
                          ),
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 200),
                      opacity: favourite ? 1 : 0,
                      child: LikeAnimation(
                        child: Icon(Icons.favorite,
                            color: Colors.white, size: 100),
                        isAnimating: favourite,
                        duration: Duration(milliseconds: 400),
                        onEnd: () {
                          setState(() {
                            favourite = false;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      LikeAnimation(
                        isAnimating: widget.snap['likes'].contains(user.uid),
                        smallLike: true,
                        child: IconButton(
                            iconSize: 25,
                            onPressed: () async {
                              FireStoreMethod().likePost(
                                widget.snap['postId'],
                                user.uid,
                                widget.snap['likes'],
                              );
                            },
                            icon: widget.snap['likes'].contains(user.uid)
                                ? Icon(Icons.favorite, color: Colors.red)
                                : Icon(Icons.favorite_border, color: Colors.white)),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.chat_bubble_outline,
                        ),
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CommentsScreen(
                              postId: widget.snap['postId'].toString(),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        iconSize: 25,
                        onPressed: () {},
                        icon: const Icon(Icons.send),
                        color: Colors.white,
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.bookmark_border),
                    color: Colors.white,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    Text(
                      "${widget.snap['likes'].length} likes",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.snap['userName'],
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          widget.snap['description'],
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CommentsScreen(
                            postId: widget.snap['postId'].toString(),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          'View all $commentLn comments',
                          style: const TextStyle(
                            fontSize: 16,
                            color: secondaryColor,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        DateFormat.yMMMd()
                            .format(widget.snap['datePublished'].toDate()),
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}

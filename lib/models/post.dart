import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String userName;
  final String postId;
  final DateTime datePublished;
  final String postUrl;
  final String profImage;
  final dynamic likes;

  Post({
    required this.description,
    required this.uid,
    required this.userName,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
    required this.likes,
  });

  Map<String, dynamic> toJson() {
    return {
      "userName": userName,
      "uid": uid,
      "description": description,
      "postId": postId,
      "datePublished": Timestamp.fromDate(datePublished), // Convert DateTime to Timestamp
      "postUrl": postUrl,
      "profImage": profImage,
      "likes": likes,
    };
  }

  static Post fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;
    return Post(
      userName: snapShot['userName'],
      uid: snapShot['uid'],
      description: snapShot['description'],
      postId: snapShot['postId'],
      datePublished: snapShot['datePublished'].toDate(), // Convert Timestamp to DateTime
      profImage: snapShot['profImage'],
      likes: snapShot['likes'],
      postUrl: snapShot['postUrl'],
    );
  }
}

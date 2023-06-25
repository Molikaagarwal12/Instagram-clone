import 'package:cloud_firestore/cloud_firestore.dart';

class Post{
  final String description;
   final String uid;
  final String  userName;
         final String postId;
         final  datePublished;
        final String postUrl;
        final String profImage;
        final likes;

    Post( {this.likes,required this.description, required this.uid, 
    required this.userName, required this.postId, required this.datePublished, required this.postUrl, required this.profImage
    });

    Map<String,dynamic> toJson()=>{
      "userName":userName,
      "uid":uid,
      "description":description,
      "postId":postId,
      "datePublished":datePublished,
      "postUrl":postUrl,
      "profImage":profImage,
      "likes":likes
    };
 static  Post fromsnap(DocumentSnapshot snap){
  var snapShot=snap.data() as Map<String,dynamic>;
  return Post(
     userName: snapShot['userName'],
     uid: snapShot['uid'],
    description: snapShot['description'],
     postId: snapShot['postId'],
     datePublished: snapShot['datePublished'],
     profImage: snapShot['profImage'],
     likes: snapShot['likes'],
    postUrl: snapShot['postUrl']
  );
 }
}
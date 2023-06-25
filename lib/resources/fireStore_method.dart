
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/resources/storage_method.dart';
import 'package:uuid/uuid.dart';

import '../models/post.dart';

class FireStoreMethod {
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String userName,
    String profImage,
    )
    async{
    String res= "some error occurred";
    try{
       String photoUrl= await StorageMethod().uploadImageToStorage('Posts',file, true);
       String postId=Uuid().v1();
       Post post=
       Post(description: description, 
       uid: uid,
        userName: userName, 
        postId: postId,
        datePublished: DateTime.now,
         postUrl: photoUrl,
          profImage: profImage,
          likes:[]
          );

          _firestore.collection('posts').doc(postId).set(post.toJson());
          res="Success";
    }catch(e){
      res=e.toString();
    }
    return res;
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String uid;
   final String email;
  final String  userName;
         final String bio;
         final List followers;
        final List following;
        final String photoUrl;

    User({required this.photoUrl, required this.uid, 
    required this.email, required this.userName, required this.bio, required this.followers, required this.following, 
      
    });

    Map<String,dynamic> toJson()=>{
      "userName":userName,
      "uid":uid,
      "email":email,
      "photoUrl":photoUrl,
      "followers":followers,
      "following":following,
      "bio":bio,
    };
 static  User fromsnap(DocumentSnapshot snap){
  var snapShot=snap.data() as Map<String,dynamic>;
  return User(
     userName: snapShot['userName'],
     uid: snapShot['uid'],
     email: snapShot['email'],
     photoUrl: snapShot['photoUrl'],
     followers: snapShot['following'],
     following: snapShot['following'],
     bio: snapShot['bio'],

  );
 }
}
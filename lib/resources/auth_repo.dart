
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:instagram_clone/models/model.dart' as model;
import 'package:instagram_clone/resources/storage_method.dart';

class AuthRepo{
  final FirebaseAuth _auth=FirebaseAuth.instance;
   final FirebaseFirestore _firestore=FirebaseFirestore.instance;

   Future<model.User> getUserDetails() async{
    User currentUser =_auth.currentUser!;
    DocumentSnapshot?  snap=await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromsnap(snap);
   }
  Future<String> signUpUser({
    required String email,
    required String password,
    required String userName,
    required String bio,
    required Uint8List file,
  }) async{
    String res="Some error occurred";
    try{
      
      if(email.isNotEmpty||password.isNotEmpty||userName.isNotEmpty||bio.isNotEmpty||file!=null){
        UserCredential cred=await _auth.createUserWithEmailAndPassword(email: email, password: password);
        print(cred.user!.uid);

      String photoUrl= await   StorageMethod().uploadImageToStorage('profilePics', file, false);

  model.User user=model.User(
        userName:userName,
      uid:cred.user!.uid,
      email:email,
      photoUrl:photoUrl,
      followers:[],
      following:[],
      bio:bio,
  );
  

        _firestore.collection('users').doc(cred.user!.uid).set(
         user.toJson()
        );
      }
    }catch(err){
      res=err.toString();
    }
    return res;
  }
  Future<String>LoginUser({
required String email,
required String password,
}) async{
  String res="Some error occurred";
  try{
    if(email.isNotEmpty||password.isNotEmpty){
     await _auth.signInWithEmailAndPassword(email: email, password: password);
     res="Success";
    }
    }on FirebaseAuthException catch(e){
      if(e.code=='user_not_found'){
        res="Enter correct email id";
             }else if(e.code=='wrong_password'){
        res="Please enter correct password";
      
      }
    }
    
     catch(err){
      res=err.toString();
    }
    return res;
  }
}



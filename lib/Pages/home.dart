import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/bubble_story.dart';
import 'package:instagram_clone/utils/user_post.dart';

import '../utils/colors.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          elevation: 0,
          title: const Text(
            "Instagram",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          actions: const [
            
            Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.messenger_outlined,
                color: Colors.white,
                size: 30,
              ),
            )
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount:snapshot.data!.docs.length,
              itemBuilder: (context,index)=> 
            UserPost(
              snap:snapshot.data!.docs[index].data()
            ));
          },
        )
        );
  }
}

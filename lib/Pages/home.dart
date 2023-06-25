import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/bubble_story.dart';
import 'package:instagram_clone/utils/user_post.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    final List people = ['Akansha',"Hariom","Satwik","Ayush","Prayas","Vinayak"];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Instagram",style: TextStyle(color: Colors.black,fontSize: 30),),
        actions: [
          
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(Icons.favorite,color: Colors.red,size: 30,),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(Icons.messenger_outline_outlined,color: Colors.black,size: 30,),
          )
        ],
        
      ),
      body: 
         Column(
           children: [
             Container(
              height: 100,
               child: ListView.builder(itemCount:people.length,itemBuilder: (context, index){
                return BuubleStories(name: people[index]);
               },
               scrollDirection: Axis.horizontal,
               ),
             ),
            //  SizedBox(height: 10,)
             Expanded(
               child: Container(
                height: MediaQuery.of(context).size.height,
                 child: ListView.builder(  
                  itemCount:people.length, itemBuilder: (context, index){
                  return UserPost(name: people[index]);
                 },scrollDirection: Axis.vertical,
                  ),
               ),
             ),
             
           ],
         )
      
    );
  }
}
import 'package:flutter/material.dart';

class UserPost extends StatefulWidget {
  final String name;
  UserPost({required this.name});

  @override
  State<UserPost> createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  bool favourite = false;
  @override
  Widget build(BuildContext context) {
    return Column(
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
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
              Icon(Icons.menu),
            ],
          ),
        ),
        Container(
          height: 400,
          color: Colors.grey[400],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
              iconSize: 25,
              onPressed: () {
                setState(() {
                  favourite = !favourite;
                });
              },
              icon: Icon(
                favourite ? Icons.favorite : Icons.favorite_border,
                color: favourite ? Colors.red : Colors.black,
              ),
            ),
            IconButton(onPressed: (){}, icon: Icon(Icons.chat_bubble_outline)),
            IconButton(onPressed: (){}, icon: Icon(Icons.telegram_sharp)),
              ],
            ),
            IconButton(onPressed: (){

            }, icon: Icon(Icons.bookmark)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
                children: [
                  Text('Liked By '),
                  Text('Molika_agarwal ',style: TextStyle(fontWeight: FontWeight.w600),),
                  Text('and'),
                  Text(' 69 others',style: TextStyle(fontWeight: FontWeight.bold),)
                ],
               ),
        ),
             Padding(
          padding: const EdgeInsets.only(left: 16,top: 5),
          child: Row(
                children: [
                  Text(widget.name,style: TextStyle(fontWeight: FontWeight.w600),),
                  const Text('  Having fun'),
                ],
               ),
        ),
      ],
    );
  }
}

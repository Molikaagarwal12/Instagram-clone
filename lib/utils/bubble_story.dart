import 'package:flutter/material.dart';

class BuubleStories extends StatelessWidget {
  final String name;

  BuubleStories({required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(padding:EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(shape: BoxShape.circle,
                color: Colors.grey,
                ),
                ),
                Text(name)
            ],
          ),
          );
  }
}
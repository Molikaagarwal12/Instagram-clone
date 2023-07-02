import 'package:flutter/material.dart';

class BuubleStories extends StatelessWidget {
  final String name;

  const BuubleStories({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            name,
            style: const TextStyle(
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}

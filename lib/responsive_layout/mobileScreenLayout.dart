import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Pages/account.dart';
import '../Pages/home.dart';
import '../Pages/reels.dart';
import '../Pages/search.dart';
import '../Pages/shop.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _selectedIndex = 0;

  void _navigateBottomNavBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> children = [
   const UserHome(),
    const SearchScreen(),
     const UserShop(),
    const UserReel(),
     ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomNavBar,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add post"),
          BottomNavigationBarItem(icon: Icon(Icons.camera), label: "Reels"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
      ),
    );
  }
}

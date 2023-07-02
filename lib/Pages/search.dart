import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../utils/colors.dart';
import 'account.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: Form(
            child: TextFormField(
              controller: searchController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Search for a user...',
                labelStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.search, color: Colors.white),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear, color: Colors.white),
                  onPressed: () {
                    searchController.clear();
                    setState(() {
                      isShowUsers = false;
                    });
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onFieldSubmitted: (String _) {
                setState(() {
                  isShowUsers = true;
                });
              },
            ),
          ),
        ),
        body: isShowUsers
            ? FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .where(
                      'userName',
                      isGreaterThanOrEqualTo: searchController.text,
                    )
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                              uid: (snapshot.data! as dynamic).docs[index]['uid'],
                            ),
                          ),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              (snapshot.data! as dynamic).docs[index]['photoUrl'],
                            ),
                            radius: 16,
                          ),
                          title: Text(
                            (snapshot.data! as dynamic).docs[index]['userName'],
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            : Padding(
              padding: const EdgeInsets.only(top: 12),
              child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('posts')
                      .orderBy('datePublished')
                      .get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                
                    return MasonryGridView.count(
                      crossAxisCount: 3,
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      itemBuilder: (context, index) => Image.network(
                        (snapshot.data! as dynamic).docs[index]['postUrl'],
                        fit: BoxFit.cover,
                      ),
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                    );
                  },
                ),
            ),
      ),
    );
  }
}

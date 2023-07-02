import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/fireStore_method.dart';
import 'package:provider/provider.dart';

import '../models/model.dart';
import '../user_provider.dart';
import '../utils/pick_image.dart';

class UserShop extends StatefulWidget {
  const UserShop({super.key});

  @override
  State<UserShop> createState() => _UserShopState();
}

class _UserShopState extends State<UserShop> {
  Uint8List? _image;
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  void postImage(
    String uid,
    String userName,
    String profImage,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FireStoreMethod().uploadPost(
        _descriptionController.text,
        _image!,
        uid,
        userName,
        profImage,
      );
      if (res == "success") {
        setState(() {
          _isLoading = false;
        });
        showSnackBar("Posted", context);
        clearImage();
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  _selectImage(BuildContext context) async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create a Post'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Choose from gallery'),
                  onTap: () async {
                    Uint8List? selectedImage = await pickImage(ImageSource.gallery);
                    setState(() {
                      _image = selectedImage;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Take a photo'),
                  onTap: () async {
                    Uint8List? selectedImage = await pickImage(ImageSource.camera);
                    setState(() {
                      _image = selectedImage;
                    });
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.cancel),
                  title: const Text('Cancel'),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void clearImage() {
    setState(() {
      _image = null;
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    User user = userProvider.getUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Create Post'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: clearImage,
        ),
        actions: [
          TextButton(
            onPressed: () => postImage(user.uid, user.userName, user.photoUrl),
            child: const Text(
              'Post',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_isLoading) const LinearProgressIndicator(),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                ),
                child: TextField(
                  controller: _descriptionController,
                  style: TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: 'Write Description....',
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                  maxLines: 10,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: GestureDetector(
                onTap: () => _selectImage(context),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: _image != null
                        ? DecorationImage(
                            image: MemoryImage(_image!),
                            fit: BoxFit.cover,
                          )
                        : null,
                    color: Colors.grey[200],
                    border: Border.all(
                      color: Colors.grey[400]!,
                      width: 2,
                    ),
                  ),
                  child: _image == null
                      ? Icon(
                          Icons.camera_alt,
                          color: Colors.grey[600],
                          size: 60,
                        )
                      : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

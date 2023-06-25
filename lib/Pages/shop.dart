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
  final TextEditingController _descriptionController=TextEditingController();

void postImage(
   String uid,
  String userName,
  String profImage
)async{
 try{
     String res= await FireStoreMethod().uploadPost(_descriptionController.text,
      _image!, uid, userName, profImage);
      if(res=="success") showSnackBar("Posted", context);
      else showSnackBar(res, context);
 }catch(e) {
         showSnackBar(e.toString(), context);
 }

}

 _selectImage(BuildContext context) async {
  // Uint8List? imageFromGallery = await pickImage(ImageSource.gallery);
  // Uint8List? imageFromCamera = await pickImage(ImageSource.camera);

   showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Create a Post'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from gallery'),
onTap: () async {
                  Uint8List? selectedImage = await pickImage(ImageSource.gallery);
                  setState(() {
                    _image = selectedImage;
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a photo'),
                onTap: () async {
                  Uint8List? selectedImage = await pickImage(ImageSource.camera);
                  setState(() {
                    _image = selectedImage;
                  });
                  Navigator.of(context).pop();
                },
              ),
                            ListTile(
                leading: Icon(Icons.cancel),
                title: Text('Cancel'),
                onTap: ()  {
                  
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

@override
  void dispose() {
    // TODO: implement dispose
    _descriptionController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    final UserProvider userProvider = Provider.of<UserProvider>(context);
    User user = userProvider.getUser;
    double screenWidth = MediaQuery.of(context).size.width;
    return _image==null? Center(
          child: IconButton(
            icon: Icon(Icons.upload),
            onPressed: ()=>_selectImage(context)
    ),
    )
    :Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Post To'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          TextButton(
            onPressed: ()=> postImage(user.uid, user.userName, user.photoUrl),
            child: Text(
              'Post',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
      
      body: Column(
       
        children: [
           SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              CircleAvatar(
               backgroundImage: NetworkImage(user.photoUrl),
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: screenWidth*0.45, // Example value, adjust as needed
                ),
                child: TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Write Description....',
                    border: InputBorder.none,
                  ),
                  maxLines: 20,
                ),
              ),
              SizedBox(
                height: 45,
                width: 45,
                child: AspectRatio(
                  aspectRatio:487/451,
                  child: Container(
                    decoration: BoxDecoration(
                      image:  DecorationImage(image:MemoryImage(_image!),
                      // fit: BoxFit.fill,
                      alignment: FractionalOffset.topCenter,
                      )
                    ),
                  ),
                  ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

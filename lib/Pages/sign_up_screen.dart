import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/Pages/login_screen.dart';
import 'package:instagram_clone/resources/auth_repo.dart';
import 'package:instagram_clone/responsive_layout/mobileScreenLayout.dart';
import 'package:instagram_clone/responsive_layout/responsive.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

import '../responsive_layout/webSceenLayout.dart';
import '../utils/pick_image.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  Uint8List? _image;
bool _isLoading=false;

  @override
  void dispose() {
 emailController.dispose();
    passwordController.dispose();
    userController.dispose();
    bioController.dispose();
    super.dispose();
  }

  Future<void> selectImage(BuildContext context) async {
  // Uint8List? imageFromGallery = await pickImage(ImageSource.gallery);
  // Uint8List? imageFromCamera = await pickImage(ImageSource.camera);

   showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select Image'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
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
                title: Text('Camera'),
                onTap: () async {
                  Uint8List? selectedImage = await pickImage(ImageSource.camera);
                  setState(() {
                    _image = selectedImage;
                  });
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

void signUpUser() async{
  setState(() {
    _isLoading=true;
  });
                  String res=await AuthRepo().signUpUser
                  (email: emailController.text,
                  password:passwordController.text, 
                  userName:userController.text,
                   bio: bioController.text, 
                   file: _image!);

                   setState(() {
                     _isLoading=false;
                   });
          if(res!='success'){
            showSnackBar(res, context);
          }
 else{
           Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context)=> ResponsiveLayout(
                webScreenLayout: WebScreenLayout(), 
                mobileScreenLayout: MobileScreenLayout())
           ));
          }
          setState(() {
            _isLoading=false;
          });
}
 void navigateToLogin(){
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context)=>LoginScreen()));
 }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            SizedBox(height: 100),
            Center(
              child: SvgPicture.network(
  'https://raw.githubusercontent.com/RivaanRanawat/instagram-flutter-clone/57f92e50238913d1a77b082ea8b061cda74865c9/assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  _image!=null?
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: MemoryImage(_image!)
                  ):CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png')
                  ),
                  Positioned(
                    top: 80,
left: 80,
                    child: IconButton(
                      icon: Icon(Icons.add_a_photo_sharp),
                      onPressed: () => selectImage(context),
                      iconSize: 45,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFieldInput(
                textEditingController: userController,
                hintText: 'Enter your Username',
                type: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFieldInput(
                textEditingController: emailController,
                hintText: 'Enter your email',
 type: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFieldInput(
                textEditingController: passwordController,
                hintText: 'Password',
                isPass: true,
                type: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFieldInput(
                textEditingController: bioController,
                hintText: 'Bio',
                type: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
 child: InkWell(
                onTap: signUpUser,
                child: _isLoading?Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                ):
                Container(
                  color: Colors.blue,
                  height: 40,
                  width: 340,
                  child: Center(
                    child: Text('Sign Up', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
            Flexible(child: Container(), flex: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.white, fontSize: 20),
),
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
                GestureDetector(
                  onTap: navigateToLogin,
                  child: Container(
                    child: Text(
                      "Login.",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/Pages/sign_up_screen.dart';
import 'package:instagram_clone/resources/auth_repo.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/pick_image.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

import '../responsive_layout/mobileScreenLayout.dart';
import '../responsive_layout/responsive.dart';
import '../responsive_layout/webSceenLayout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthRepo().LoginUser(
      email: emailController.text,
      password: passwordController.text,
    );
    if (res == 'success') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
    } else {
      showSnackBar(res, context);
    }
  }

  void navigateToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 250),
                  Center(
                    child: SvgPicture.network(
                      'https://raw.githubusercontent.com/RivaanRanawat/instagram-flutter-clone/57f92e50238913d1a77b082ea8b061cda74865c9/assets/ic_instagram.svg',
                      color: primaryColor,
                      height: 64,
                    ),
                  ),
                  SizedBox(height: 20),
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
                    child: InkWell(
                      onTap: loginUser,
                      child: _isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Container(
                              color: Colors.blue,
                              height: 40,
                              width: 370,
                              child: Center(
                                child: Text(
                                  'Log in',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      GestureDetector(
                        onTap: navigateToSignUp,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Sign up.",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

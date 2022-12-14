import 'package:bhavipath/screens/course_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../helper.dart';
import '../reusable_widgets.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _userController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff001039), Color(0xff01091d)],
              begin: FractionalOffset(0.0, 1.0),
              end: FractionalOffset(0.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
          // image: DecorationImage(image: AssetImage("android/assets/a[[.png")),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 3,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Container(
                    height: 150,
                    width: 150,
                    child: Image(
                      image: AssetImage('android/assets/bp logo.png'),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    height: 460,
                    width: 324,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 26,
                        ),
                        Text(
                          'Sign Up',
                          style: GoogleFonts.firaSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              color: Color(0xff0D0C0C)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        reusableTextField(
                            "username", Icons.person, false, _userController),
                        reusableTextField(
                            " email", Icons.mail, false, _emailController),
                        reusableTextField(" password", Icons.key_sharp, true,
                            _passwordController),
                        SignInSignUpButton(context, false, () {
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text)
                              .then((value) {
                            Map<String, String> userInfoMap = {
                              "name": _userController.text,
                              "email": _emailController.text,
                            };

                            HelperFunctions.saveuserEmailSharePreference(
                                _emailController.text);
                            HelperFunctions.saveuserNameSharePreference(
                                _userController.text);

                            setState(() {
                              isLoading = true;
                            });
                            // databaseMethods.uploadUserInfo(userInfoMap);
                            HelperFunctions.saveuserLoggedInSharePreference(
                                true);
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CourseScreen()))
                                .onError((error, stackTrace) {
                              print("Error ${error.toString()}");
                            });
                          });
                        })
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 60,
            )
          ],
        ),
      ),
    );
  }
}

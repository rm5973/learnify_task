import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learnify_task/verification_dialog.dart';

import 'auth_service.dart'; // Import your Firebase Authentication service

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _onLogInPressed() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Call the authentication service to sign in
    User? user = await AuthService().signInWithEmailPassword(email, password);

    if (user != null) {
      // Authentication was successful, show the verification dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return VerificationDialog(); // Your custom dialog widget
        },
      );
    } else {
      // Authentication failed, show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed. Please check your credentials.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double textSize = screenWidth * 0.07;
    double padding = MediaQuery.of(context).size.height * 0.05;
    double imageWidth = screenWidth * 0.8;
    double imageHeight = MediaQuery.of(context).size.height * 0.4;

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: padding),
                  child: Center(
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        color: (Colors.black),
                        fontSize: textSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenWidth * 0.15,
                ),
                SizedBox(
                  width: imageWidth,
                  height: imageHeight,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        0.3 * imageWidth), // 30% round corners
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.2), // 5% transparency
                        BlendMode.srcOver,
                      ),
                      child: Image.asset(
                        'images/photo1.png', // Replace with your asset image path
                        fit: BoxFit.cover, // Adjust the fit as needed
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.0),
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(0.3 * screenWidth),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 10.0),
                      Expanded(
                        child: TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0), // Add some spacing
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(0.3 * screenWidth),
                  ),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true, // Hide the password
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 40.0),
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: ElevatedButton(
                    onPressed: _onLogInPressed,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      alignment: Alignment.center,
                      child: Text('Get OTP'),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    'By signing up you agree to our terms and conditions',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

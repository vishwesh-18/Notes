import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:notes/Controller/SignupController.dart';


import 'LoginScreen.dart';

class SignUpScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final SignupController signupController=Get.put(SignupController());
    return Scaffold(
      backgroundColor: Colors.white, // White background
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title
            Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Black text
              ),
            ),
            SizedBox(height: 40), // Space between title and form

            // Email TextField
            TextField(
              controller: signupController.emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.black),
                hintText: 'Enter your email',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color: Colors.black), // Black text input
            ),
            SizedBox(height: 20), // Space between email and password input

            // Password TextField
            TextField(
              controller: signupController.passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.black),
                hintText: 'Enter your password',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color: Colors.black), // Black text input
            ),
            SizedBox(height: 20), // Space between password and confirm password

            // Confirm Password TextField
            TextField(
              controller: signupController.confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                labelStyle: TextStyle(color: Colors.black),
                hintText: 'Confirm your password',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color: Colors.black), // Black text input
            ),
            SizedBox(height: 40), // Space before sign-up button

            // Sign-Up Button
            ElevatedButton(
              onPressed: () async {


             await    signupController.registerUser();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: Text('Sign Up'),
              style: ElevatedButton.styleFrom(
backgroundColor: Color(0xFFf6f6f6),
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20), // Space before login button

            // Login Button
            TextButton(
              onPressed: () {
                //LoginScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: Text(
                'Already have an account? Login',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



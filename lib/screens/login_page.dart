import 'package:flutter/material.dart';
import 'package:firebase_firestoreapp/services/firebaseauth_service.dart';
import 'package:firebase_firestoreapp/screens/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Controllers for e-mail and password textfields.
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool signUp = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //hide back arrow button
        automaticallyImplyLeading: false,
        title: Text('Login'),
        backgroundColor: Colors.green, // Set app bar background color
      ),
      backgroundColor: Colors.white, // Set background color of the screen
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Waste Wise",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green, // Set text color
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                "Register",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green, // Set text color
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                onPressed: () async {
                  if (signUp) {
                    var newuser = await FirebaseAuthService().signUp(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                    if (newuser != null) {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }
                  } else {
                    var reguser = await FirebaseAuthService().signIn(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                    if (reguser != null) {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }
                  }
                },
                child: signUp
                    ? Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white),
                      )
                    : Text(
                        "Sign In",
                        style: TextStyle(color: Colors.white),
                      ),
                color: Colors.green, // Set button color
              ),
              SizedBox(height: 10.0),
              OutlineButton(
                onPressed: () {
                  setState(() {
                    signUp = !signUp;
                  });
                },
                child: signUp
                    ? Text(
                        "Have an account? Sign In",
                        style: TextStyle(color: Colors.green),
                      )
                    : Text(
                        "Create an account",
                        style: TextStyle(color: Colors.green),
                      ),
                borderSide:
                    BorderSide(color: Colors.green), // Set button border color
              )
            ],
          ),
        ),
      ),
    );
  } //build
} //_LoginPageState

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_firestoreapp/screens/controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatelessWidget {
  var controller = Get.put(Controller()); // Using GetX for state management

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.green, // Change app bar background color
      ),
      body: Center(
        child: StreamBuilder<User>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              if (snapshot.hasData) {
                // User is signed in
                String email = snapshot.data.email ?? '';
                String displayEmail = email.replaceFirst(RegExp(r'@.*'), '');
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _getImage(context); // Function to pick profile image
                        },
                        child: Obx(
                          () => CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                controller.profileImage.value != null
                                    ? FileImage(controller.profileImage.value)
                                    : NetworkImage(
                                        'https://via.placeholder.com/150',
                                      ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Welcome, $displayEmail',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Email: ${snapshot.data.email}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'UID: ${snapshot.data.uid}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _editPassword(context); // Function to edit password
                        },
                        child: Text(
                          'Change Password',
                          style: TextStyle(color: Colors.white), // Text color
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green, // Background color
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                // User is signed out
                return Text('User is currently signed out!');
              }
            }
          },
        ),
      ),
    );
  }

  // Function to pick profile image
  void _getImage(BuildContext context) async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File image = File(pickedFile.path);
      controller.setProfileImage(image);
    } else {
      print('No image selected.');
    }
  }

  // Function to edit password
  void _editPassword(BuildContext context) {
    String newPassword = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                obscureText: true,
                decoration: InputDecoration(hintText: 'Enter new password'),
                onChanged: (value) {
                  newPassword = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  // Update password
                  if (newPassword.isNotEmpty) {
                    await FirebaseAuth.instance.currentUser
                        .updatePassword(newPassword);
                  }

                  // Close dialog
                  Navigator.of(context).pop();
                } catch (error) {
                  // Display error message (optional)
                  print('Error updating password: $error');
                  // Show error message to the user
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text(error.toString()),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Save'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Background color
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:get/get.dart';
import 'package:firebase_firestoreapp/screens/controller.dart';
import 'package:firebase_firestoreapp/screens/learnpage.dart';

class ShowArticlePage extends StatelessWidget {
  DocumentSnapshot article; // Declare article as a property

  // Constructor to receive the article data
  ShowArticlePage({@required this.article});

  @override
  Widget build(BuildContext context) {
    var cartController = Get.put(Controller());
    return Scaffold(
      appBar: AppBar(
        title: Text('Article Details'),
        backgroundColor: Colors.green, // Set app bar background color to green
      ),
      body: SingleChildScrollView(
        // Use SingleChildScrollView to enable scrolling
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title section
              Text(
                'Title:', // Title label
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                article['Title'], // Display article title
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 20.0),
              // Author section
              Text(
                'Author:', // Author label
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                article['Author'], // Display article author
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 20.0),
              // Description section
              Text(
                'Description:', // Description label
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                article['Description'], // Display article description
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

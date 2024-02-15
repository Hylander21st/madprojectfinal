import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_firestoreapp/screens/controller.dart';

class ChallengePage extends StatelessWidget {
  // Lists to store weekly and daily challenges
  List<String> weeklyChallenges;
  List<String> dailyChallenges;

  // Constructor to initialize weekly and daily challenges
  ChallengePage({this.weeklyChallenges, this.dailyChallenges});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Challenges'),
        backgroundColor: Colors.green, // Change app bar background color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Container for displaying user points
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.lightGreen, // Change color scheme
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '100',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                            ),
                          ),
                          SizedBox(width: 5.0),
                          Icon(
                            Icons.star,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Points',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 25.0),

            // Weekly Challenges
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Weekly Challenges',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  // Building weekly challenge items
                  _buildChallengeItem('Read 5 articles', 0.8),
                  _buildChallengeItem('Watch 2 videos', 0.5),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            // Daily Challenges
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Daily Challenges',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  // Building daily challenge items
                  _buildChallengeItem('Watch a video', 0),
                  _buildChallengeItem('Read 1 article', 0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build each challenge item
  Widget _buildChallengeItem(String challengeName, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          challengeName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5.0),
        // Progress bar for challenge completion
        LinearProgressIndicator(
          value: progress,
          minHeight: 10.0,
          backgroundColor:
              Colors.grey[300], // Change progress bar background color
          valueColor: AlwaysStoppedAnimation<Color>(
              Colors.green), // Change progress bar color
        ),
        SizedBox(height: 10.0),
      ],
    );
  }
}

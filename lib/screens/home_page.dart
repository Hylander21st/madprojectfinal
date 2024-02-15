import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_firestoreapp/screens/about_page.dart';
import 'package:firebase_firestoreapp/screens/centreguide_page.dart';
import 'package:firebase_firestoreapp/screens/challenge_page.dart';
import 'package:firebase_firestoreapp/screens/profile_page.dart';
import 'package:firebase_firestoreapp/screens/learnpage.dart';
import 'package:firebase_firestoreapp/screens/reports.dart';
import 'package:firebase_firestoreapp/screens/report_page.dart';
import 'package:firebase_firestoreapp/services/firebaseauth_service.dart';
import 'package:firebase_firestoreapp/screens/controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cartController = Get.put(Controller());
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.green, // Change app bar background color
        actions: [
          // Action button to navigate to profile page or login page if user is not logged in
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              if (!FirebaseAuthService().isLoggedIn()) {
                Navigator.of(context).pushNamed('/login');
              } else {
                Get.to(() => ProfilePage());
              }
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Drawer header with logo
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green, // Change drawer header color
              ),
              child: Center(
                child: Image.asset(
                  'images/wastewise.png',
                  height: 100,
                ),
              ),
            ),
            // List of options in the drawer for navigation
            ListTile(
              title: Text('About Waste Wise'),
              onTap: () {
                Get.to(() => AboutPage());
              },
            ),
            ListTile(
              title: Text('Learn about Recylcing'),
              onTap: () {
                Get.to(() => LearnPage());
              },
            ),
            ListTile(
              title: Text('Location and Item Guide'),
              onTap: () {
                Get.to(() => CentersAndItemsPage());
              },
            ),
            ListTile(
              title: Text('Make a Report '),
              onTap: () {
                Get.to(() => ReportPage());
              },
            ),
            ListTile(
              title: Text('Show Reports'),
              onTap: () {
                Get.to(() => ShowReportsPage());
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Challenges card with progress indicators
            _buildCard(
              title: 'Challenges',
              onTap: () {
                Get.to(() => ChallengePage());
              },
              children: [
                _buildChallengeItem('Read 5 articles', 0.8),
                _buildChallengeItem('Watch 2 videos', 0.5),
              ],
            ),
            SizedBox(height: 20.0),
            // Learn card with different learning options
            _buildCard(
              title: 'Learn about Waste Reduction',
              onTap: () {
                Get.to(() => LearnPage());
              },
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildLearnCardItem('Tips', Icons.lightbulb,
                          onTap: () {
                        // Handle tap for 'Tips'
                        print('Tips tapped!');
                      }),
                    ),
                    SizedBox(width: 20.0),
                    Expanded(
                      child: _buildLearnCardItem('Articles', Icons.article,
                          onTap: () {
                        // Handle tap for 'Articles'
                        print('Articles tapped!');
                      }),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                _buildLearnCardItem('Videos', Icons.video_library, onTap: () {
                  // Handle tap for 'Videos'
                  print('Videos tapped!');
                }),
              ],
            ),
            SizedBox(height: 20.0),
            // Recycling guide card with guide and report options
            _buildCard(
              title: 'Recycling Guide',
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildRecyclingCardItem(
                        label: 'Guide',
                        icon: Icons.book,
                        onTap: () {
                          Get.to(() => CentersAndItemsPage());
                        },
                      ),
                    ),
                    SizedBox(width: 20.0),
                    Expanded(
                      child: _buildRecyclingCardItem(
                        label: 'Report',
                        icon: Icons.report,
                        onTap: () {
                          Get.to(() => ReportPage());
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.logout),
        backgroundColor: Colors.blueAccent,
        tooltip: 'Sign Out',
        onPressed: () async {
          // Functionality to sign out the user
          await FirebaseAuthService().signOut();
          Navigator.of(context).pushNamed('/login');
        },
      ),
    );
  }

  // Widget for building cards with titles and content
  Widget _buildCard({String title, Function onTap, List<Widget> children}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              ...children,
            ],
          ),
        ),
      ),
    );
  }

  // Widget for building challenge items with progress indicators
  Widget _buildChallengeItem(String challengeName, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(challengeName),
        SizedBox(height: 5.0),
        LinearProgressIndicator(
          value: progress,
          minHeight: 10.0,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
        ),
        SizedBox(height: 10.0),
      ],
    );
  }

  // Widget for building learn card items
  Widget _buildLearnCardItem(String label, IconData icon, {Function onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity:
            onTap != null ? 1.0 : 0.5, // Adjust opacity based on onTap presence
        child: Container(
          height: 100.0,
          decoration: BoxDecoration(
            color: Colors.lightGreen,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.black, // Border color for clickable buttons
            ),
          ),
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                size: 36.0,
                color: Colors.black,
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for building recycling guide card items
  Widget _buildRecyclingCardItem(
      {String label, IconData icon, Function onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity:
            onTap != null ? 1.0 : 0.5, // Adjust opacity based on onTap presence
        child: Container(
          height: 100.0,
          decoration: BoxDecoration(
            color: Colors.lightGreen,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.black, // Border color for clickable buttons
            ),
          ),
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                size: 36.0,
                color: Colors.black,
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

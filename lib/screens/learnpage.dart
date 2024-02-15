import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_firestoreapp/screens/controller.dart';
import 'package:firebase_firestoreapp/screens/showarticle_page.dart';
import 'package:firebase_firestoreapp/screens/videoplayer.dart';

class LearnPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using GetX for state management
    var cartController = Get.put(Controller());
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn about Recycling'),
        backgroundColor: Colors.green, // Change app bar background color
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Videos
            Text(
              'Videos ',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),

            // StreamBuilder to listen for changes in Firestore collection
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Videos').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    // Wrap to display videos in a row
                    return Wrap(
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        String videoUrl = document['link'];
                        return _buildVideoSquare(videoUrl, document);
                      }).toList(),
                    );
                }
              },
            ),

            SizedBox(height: 20.0),

            // Articles
            Text(
              'Articles ',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),

            // Container to display articles in a horizontal ListView
            Container(
              height: 150.0,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Articles')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    default:
                      // ListView to display articles horizontally
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        children:
                            snapshot.data.docs.map((DocumentSnapshot document) {
                          return _buildArticleCard(document);
                        }).toList(),
                      );
                  }
                },
              ),
            ),
            SizedBox(height: 20.0),

            // Tips
            Text(
              'Tips ',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),

            // Container to display tips in a horizontal ListView
            Container(
              height: 150.0,
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('Tips').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    default:
                      // ListView to display tips horizontally
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        children:
                            snapshot.data.docs.map((DocumentSnapshot document) {
                          return _buildTipCard(document);
                        }).toList(),
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build each video square
  Widget _buildVideoSquare(String videoUrl, DocumentSnapshot document) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Get.to(() => VideoPlayerScreen(videoUrl: videoUrl));
        },
        child: Container(
          height: 100.0,
          width: 400.0,
          decoration: BoxDecoration(
            color: Colors.lightGreen, // Indicating Clickable
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 5.0,
                spreadRadius: 1.0,
                offset: Offset(0, 2),
              ),
            ],
            border: Border.all(
              color: Colors.black, // Border color for clickable buttons
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.video_library, // Video icon
                size: 40,
                color: Colors.black,
              ),
              SizedBox(height: 8),
              Text(
                document['VideoName'],
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to build each article card
  Widget _buildArticleCard(DocumentSnapshot document) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ShowArticlePage(article: document));
      },
      child: Container(
        width: 200.0,
        margin: EdgeInsets.only(right: 10.0),
        decoration: BoxDecoration(
          color: Colors.lightGreen, // Indicating Clickable
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 5.0,
              spreadRadius: 1.0,
              offset: Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: Colors.black, // Border color for clickable buttons
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.article, // Article icon
              size: 40,
              color: Colors.black,
            ),
            SizedBox(height: 8),
            Text(
              document['Title'],
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build each tip card
  Widget _buildTipCard(DocumentSnapshot document) {
    return Container(
      width: 200.0,
      margin: EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
        color: Colors.lightGreen,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5.0,
            spreadRadius: 1.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            document['Tip'],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

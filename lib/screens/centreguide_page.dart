import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Model class for center data
class CenterData {
  final String imageUrl;
  final String name;
  final String location;

  CenterData({
    @required this.imageUrl,
    @required this.name,
    @required this.location,
  });
}

// Model class for item data
class ItemData {
  final String imageUrl;
  final String name;
  final String description;

  ItemData({
    @required this.imageUrl,
    @required this.name,
    @required this.description,
  });
}

// Page to display centers and items
class CentersAndItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Centres and Items'),
        backgroundColor: Colors.green, // Change app bar background color
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Displaying centers
            Text(
              'Centres near you',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Center').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                // Parsing center data from Firestore snapshot
                List<CenterData> centers = snapshot.data.docs.map((doc) {
                  return CenterData(
                    imageUrl: doc['img'],
                    name: doc['Name'],
                    location: doc['location'],
                  );
                }).toList();

                // Displaying centers in a horizontal list view
                return SizedBox(
                  height: 160.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: centers.length,
                    itemBuilder: (context, index) {
                      return CenterCard(center: centers[index]);
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 20.0),
            // Displaying items
            Text(
              'Recyclable items',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Items').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                // Parsing item data from Firestore snapshot
                List<ItemData> items = snapshot.data.docs.map((doc) {
                  return ItemData(
                    imageUrl: doc['img'],
                    name: doc['name'],
                    description: doc['desc'],
                  );
                }).toList();

                // Displaying items in a horizontal list view
                return SizedBox(
                  height: 160.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ItemCard(item: items[index]);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for displaying center card
class CenterCard extends StatelessWidget {
  final CenterData center;

  const CenterCard({Key key, @required this.center}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.lightGreen, // Change card background color
      ),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            center.imageUrl,
            height: 100.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8.0),
          Text(
            center.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(center.location),
        ],
      ),
    );
  }
}

// Widget for displaying item card
class ItemCard extends StatelessWidget {
  final ItemData item;

  const ItemCard({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.lightGreen, // Change card background color
      ),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            item.imageUrl,
            height: 100.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8.0),
          Text(
            item.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(item.description),
        ],
      ),
    );
  }
}

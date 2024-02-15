import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Model class for a report
class Report {
  final String id;
  final String imageUrl;
  final String location;
  final String description;

  Report({
    @required this.id,
    @required this.imageUrl,
    @required this.location,
    @required this.description,
  });

  // Factory method to create a Report object from a DocumentSnapshot
  factory Report.fromMap(DocumentSnapshot doc) {
    return Report(
      id: doc.id,
      imageUrl: doc['imageUrl'] ?? '',
      location: doc['location'] ?? '',
      description: doc['description'] ?? '',
    );
  }
}

class ShowReportsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
        backgroundColor: Colors.green, // Change app bar background color
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('reports').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show loading indicator while waiting for data
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            // Show error message if there's an error
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          // Extract list of reports from snapshot
          List<Report> reports = snapshot.data.docs.map((doc) {
            return Report.fromMap(doc);
          }).toList();

          return ListView.builder(
            itemCount: reports.length,
            itemBuilder: (context, index) {
              Report report = reports[index];
              return ListTile(
                // Display report details in ListTile
                leading: report.imageUrl.isNotEmpty
                    ? Image.memory(
                        base64Decode(report.imageUrl),
                        width: 100, // Adjust image width
                        height: 100, // Adjust image height
                      )
                    : SizedBox.shrink(), // Hide leading widget if no image
                title: Text(report.location),
                subtitle: Text(report.description),
                onTap: () {
                  // Show edit report dialog when ListTile is tapped
                  _showEditReportDialog(context, report);
                },
              );
            },
          );
        },
      ),
    );
  }

  // Function to show edit report dialog
  void _showEditReportDialog(BuildContext context, Report report) {
    TextEditingController locationController =
        TextEditingController(text: report.location);
    TextEditingController descriptionController =
        TextEditingController(text: report.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Report'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Text fields for editing location and description
              TextField(
                controller: locationController,
                decoration: InputDecoration(labelText: 'Location'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            // Cancel button
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            // Save button
            FlatButton(
              onPressed: () {
                // Update report data in Firestore
                String newLocation = locationController.text;
                String newDescription = descriptionController.text;

                FirebaseFirestore.instance
                    .collection('reports')
                    .doc(report.id)
                    .update({
                  'location': newLocation,
                  'description': newDescription,
                });

                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

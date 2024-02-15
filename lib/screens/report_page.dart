import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_firestoreapp/services/firestore_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;
  TextEditingController _locationController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  // Function to pick image from camera
  Future<void> _pickImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  // Function to submit report
  Future<void> _submitReport() async {
    String location = _locationController.text;
    String description = _descriptionController.text;

    // Check if all fields are filled and image is picked
    if (_imageFile == null || location.isEmpty || description.isEmpty) {
      Fluttertoast.showToast(msg: 'Please fill all fields and pick an image');
      return;
    }

    // Read image file as bytes and encode it to base64
    List<int> imageBytes = await File(_imageFile.path).readAsBytes();
    String base64Image = base64Encode(imageBytes);

    // Add report data to Firestore
    await FirestoreService().addReportData(location, description, base64Image);
    Fluttertoast.showToast(msg: 'Report submitted successfully');
    // Clear text fields and image
    _locationController.clear();
    _descriptionController.clear();
    setState(() {
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Make a Report'),
        backgroundColor: Colors.green, // Change app bar background color
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Display selected image or placeholder
            _imageFile != null
                ? Image.file(File(_imageFile.path))
                : Placeholder(fallbackHeight: 200),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Take Picture'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Change button color
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Text field for location
                  TextField(
                    controller: _locationController,
                    decoration: InputDecoration(labelText: 'Location'),
                  ),
                  SizedBox(height: 10),
                  // Text field for description
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                    maxLines: 3,
                  ),
                  SizedBox(height: 20),
                  // Button to submit report
                  ElevatedButton(
                    onPressed: _submitReport,
                    child: Text('Submit Report'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, // Change button color
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose text controllers when widget is disposed
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  // Function to launch phone call
  void _launchPhoneCall() async {
    const phoneNumber = 'tel:93825026';
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  // Function to launch email
  void _launchEmail() async {
    const email = 'mailto:contact@wastewise.com';
    if (await canLaunch(email)) {
      await launch(email);
    } else {
      throw 'Could not launch $email';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Waste Wise'),
        backgroundColor: Colors.green, // Change app bar background color
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              'Waste Wise',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Image.asset(
              'images/wastewise.png', // Assuming you have the image in the assets folder
              height: 200,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Waste Wise is dedicated to promoting environmental sustainability '
                'by educating individuals about waste management and encouraging '
                'practices that reduce waste generation and promote recycling. '
                'Through our initiatives and programs, we aim to create a '
                'more eco-conscious community that actively contributes '
                'to a cleaner and healthier planet.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Buttons for calling and emailing
            ElevatedButton(
              onPressed: _launchPhoneCall,
              child: Text('Call Us'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Change button color
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _launchEmail,
              child: Text('Email Us'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Change button color
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

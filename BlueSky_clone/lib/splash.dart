import 'package:flutter/material.dart';
import 'dart:async';
import 'pages/home.dart';  // Updated import here

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7vWOja3_rZY0I8N0jbVmPWlaSeqxVYcIzPA&s',
          width: 200,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.error, color: Colors.red); // Show error icon if image fails to load
          },
        ),
      ),
    );
  }
}

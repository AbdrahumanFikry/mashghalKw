import 'package:flutter/material.dart';

class AppLogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 30.0,
      ),
      child: CircleAvatar(
        radius: 80.0,
        backgroundColor: Colors.white,
        child: Image.asset(
          'assets/images/logoImage.PNG',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

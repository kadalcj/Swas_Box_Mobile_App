import 'package:bank_sampah_mobile/screen/landing_page.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingPage(),
    );
  }
}
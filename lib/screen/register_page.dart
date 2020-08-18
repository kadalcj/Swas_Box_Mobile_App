import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              _titleText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleText() {
    return Container(
      child: Column(
        children: [
          Text('Mulai Mendaftar'),
        ],
      ),
    );
  }
}

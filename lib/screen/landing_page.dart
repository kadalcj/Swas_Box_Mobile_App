import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.green,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _titleContainer(context),
          ],
        ),
      ),
    );
  }

  Widget _titleContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Text(
              'SWAKIMAN BOX',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            'Mari Memulai Kebiasaan Baik Sejak Dini',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: Text(
              'Dengan Cara Menabung Sampah',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          InkWell(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(8.0),
                color: Colors.green,
              ),
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Ayo Mulai',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              top: 20.0,
              left: 20.0,
              right: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _welcomeContainer('Ilham Wahyu'),
                _poinContainer(
                  context,
                  '69',
                ),
                _myActivityContainer()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _welcomeContainer(String firstName) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Ayo Mulai Menabung,',
            style: TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(
            '$firstName',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }

  Widget _poinContainer(BuildContext context, String poin) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(8.0),
        color: Colors.green,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Saldo',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Total Saldo Saat Ini',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          '$poin Poin',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        InkWell(
                          child: Container(
                            child: Text(
                              'Lihat Detail',
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w300,
                                decoration: TextDecoration.underline,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/savingDetail');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 6.0,
            ),
            child: _dividerContainer(),
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/qr_code_icon.svg',
                  ),
                  Text(
                    'Scan',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              // TODO: Open QR Code Scanner and pushNamed to '/saving'
              Navigator.pushNamed(context, '/saving');
            },
          ),
        ],
      ),
    );
  }

  Widget _dividerContainer() {
    return Container(
      width: 1.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
    );
  }

  Widget _myActivityContainer() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      child: Column(
        children: [
          Text(
            'My Activity',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

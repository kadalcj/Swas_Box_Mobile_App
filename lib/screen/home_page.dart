import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bank_sampah_mobile/repository/user_repository.dart';
import 'package:bank_sampah_mobile/bloc/refresh_poin/refresh_poin_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _userId;
  String _firstName;
  int _poin;

  Future _initPrefs() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    setState(() {
      this._userId = _prefs.getString('_id');
      this._firstName = _prefs.getString('firstName');
      this._poin = _prefs.getInt('poin');
    });
  }

  @override
  void initState() {
    super.initState();

    _initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider<RefreshPoinBloc>(
        create: (context) => RefreshPoinBloc(UserRepository()),
        child: SafeArea(
          child: BlocConsumer<RefreshPoinBloc, RefreshPoinState>(
            listener: (context, state) {
              if (state is RefreshPoinIsLoaded) {
                return _initPrefs();
              } else if (state is RefreshPoinIsError) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is RefreshPoinInitial) {
                return _initPage(context);
              } else if (state is RefreshPoinIsLoading) {
              } else if (state is RefreshPoinIsLoaded) {
                return _initPage(context);
              }

              return _initPage(context);
            },
          ),
        ),
      ),
    );
  }

  Widget _initPage(BuildContext context) {
    return RefreshIndicator(
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
              _welcomeContainer(_firstName),
              _poinContainer(
                context,
                _poin.toString(),
              ),
              _allertCovContainer()
            ],
          ),
        ),
      ),
      onRefresh: () async {
        context.bloc<RefreshPoinBloc>().add(
              RefreshPoin(_userId),
            );
      },
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
                    color: Colors.white,
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
            onTap: () async {
              Navigator.pushNamed(context, '/saving').then((_) {
                return _initPrefs();
              });
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

  Widget _allertCovContainer() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 20.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.grey[100],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Himbauan Covid - 19',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Ayo Cegah Penularan Covid - 19 Dengan Cara Patuhi Protokol Kesehatan.',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  '1. Menggunakan Masker',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: double.infinity,
                  height: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.green,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  '2. Mencuci Tangan Menggunakan Sabun',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: double.infinity,
                  height: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.green,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  '3. Menjaga Jarak',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: double.infinity,
                  height: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.green,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Text(
                    'Salam Sehat Dan Semangat',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

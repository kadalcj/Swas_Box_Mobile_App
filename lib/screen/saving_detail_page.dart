import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bank_sampah_mobile/bloc/trash/trash_bloc.dart';
import 'package:bank_sampah_mobile/repository/trash_repository.dart';

import 'package:bank_sampah_mobile/screen/widget/circular_container.dart';

class SavingDetailPage extends StatefulWidget {
  @override
  _SavingDetailPageState createState() => _SavingDetailPageState();
}

class _SavingDetailPageState extends State<SavingDetailPage> {
  int _poin;

  Future _initPrefs() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    setState(() {
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
      body: BlocProvider<TrashBloc>(
        create: (context) => TrashBloc(TrashRepository()),
        child: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _saldoContainer(context, _poin.toString()),
                SizedBox(
                  height: 15.0,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Transaksi',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: BlocConsumer<TrashBloc, TrashState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                if (state is TrashInitial) {
                                  context.bloc<TrashBloc>().add(GetTrash());
                                  return Text('Tidak ada');
                                } else if (state is TrashIsLoading) {
                                  return Center(
                                    child: CircularContainer(
                                      title: 'Memuat',
                                    ),
                                  );
                                } else if (state is TrashIsLoaded) {
                                  final data = state.trash.results;

                                  if (data.isEmpty) {
                                    return Center(
                                      child: Text(
                                        'Belum Ada Transaksi',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    );
                                  }

                                  return RefreshIndicator(
                                    child: ListView.builder(
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        return _transactionDetailContainer(
                                          data[index].timestamp,
                                          data[index].name,
                                          data[index].poin.toString(),
                                        );
                                      },
                                    ),
                                    onRefresh: () async {
                                      context.bloc<TrashBloc>().add(GetTrash());

                                      return _initPrefs();
                                    },
                                  );
                                }

                                return Text('Tidak ada');
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _saldoContainer(BuildContext context, String poin) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      width: double.infinity,
      height: 200.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
        ),
        color: Colors.green,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Saldo',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    '$poin Poin',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          _dividerContainer(),
          SizedBox(
            width: 20.0,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tukar Poin',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90.0),
                        color: Colors.white),
                    child: Icon(
                      Icons.shopping_cart,
                      size: 50.0,
                      color: Colors.green,
                    ),
                  ),
                  onTap: () async {
                    Navigator.pushNamed(context, '/redeem').then(
                      (_) {
                        return _initPrefs();
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _transactionDetailContainer(
      String timestamp, String name, String poin) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey[200],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$timestamp',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    '$name',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '$poin',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dividerContainer() {
    return Container(
      width: 1.0,
      height: 150.0,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
    );
  }
}

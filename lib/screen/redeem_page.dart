import 'package:bank_sampah_mobile/model/argument/reward_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bank_sampah_mobile/bloc/reward/reward_bloc.dart';
import 'package:bank_sampah_mobile/repository/reward_repository.dart';

import 'package:bank_sampah_mobile/screen/widget/circular_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RedeemPage extends StatefulWidget {
  @override
  _RedeemPageState createState() => _RedeemPageState();
}

class _RedeemPageState extends State<RedeemPage> {
  int poin;

  Future _initPrefs() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    setState(() {
      this.poin = _prefs.getInt('poin');
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
      body: BlocProvider<RewardBloc>(
        create: (context) => RewardBloc(RewardRepository()),
        child: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _topContainer(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: Text(
                    'Pilih Product Yang Ingin Ditukar',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: BlocConsumer<RewardBloc, RewardState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is RewardInitial) {
                        context.bloc<RewardBloc>().add(GetReward());
                      } else if (state is RewardIsLoading) {
                        return Center(
                          child: CircularContainer(
                            title: 'Memuat',
                          ),
                        );
                      } else if (state is RewardIsLoaded) {
                        final data = state.reward.results;

                        if (data.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Barang Tukar Sedang Kosong',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(
                                  'Hubungi Penyedia Jasa',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return _productContainer(
                              context,
                              data[index].id,
                              data[index].name,
                              data[index].reqPoin,
                              data[index].stock,
                            );
                          },
                        );
                      }

                      return Container(
                        child: Center(
                          child: Text('Tidak Ada Reward'),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _topContainer() {
    return Container(
      height: 200.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
        ),
        color: Colors.green,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Saldo',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            Text(
              '$poin',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _productContainer(
      BuildContext context, String id, String name, int reqPoin, int stock) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 10.0,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            color: Colors.grey[200]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$name',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '1 $name = $reqPoin Poin',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Text(
                        'Stok:',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        '$stock',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 5.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: Colors.green,
                ),
                child: Text(
                  'Tukar',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              onTap: () async {
                SharedPreferences _prefs =
                    await SharedPreferences.getInstance();

                String userId = _prefs.getString('_id');

                Navigator.pushNamed(
                  context,
                  '/rewardConfirm',
                  arguments: RewardArgs(
                    userId,
                    id,
                    poin,
                    name,
                    reqPoin,
                    stock,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

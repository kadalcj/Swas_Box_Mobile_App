import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bank_sampah_mobile/bloc/invoice/invoice_bloc.dart';
import 'package:bank_sampah_mobile/repository/reward_repository.dart';
import 'package:bank_sampah_mobile/model/argument/reward_args.dart';

import 'package:bank_sampah_mobile/screen/widget/circular_container.dart';

class RedeemConfirmationPage extends StatefulWidget {
  final RewardArgs args;

  const RedeemConfirmationPage({Key key, this.args}) : super(key: key);

  @override
  _RedeemConfirmationPageState createState() =>
      _RedeemConfirmationPageState(args);
}

class _RedeemConfirmationPageState extends State<RedeemConfirmationPage> {
  final RewardArgs args;

  _RedeemConfirmationPageState(this.args);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InvoiceBloc>(
      create: (context) => InvoiceBloc(RewardRepository()),
      child: Scaffold(
        body: SafeArea(
          child: Container(
              child: BlocConsumer<InvoiceBloc, InvoiceState>(
            listener: (context, state) {
              if (state is InvoiceIsError) {
                // Navigator.pop(context);

                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(state.message),
                ));
              } else if (state is InvoiceIsLoaded) {
                Navigator.pop(context, true);
              }
            },
            builder: (context, state) {
              if (state is InvoiceisLoading) {
                return Center(
                  child: CircularContainer(
                    title: 'Mohon Tunggu',
                  ),
                );
              }

              return _initialPage(context);
            },
          )),
        ),
      ),
    );
  }

  Widget _initialPage(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _titleContainer(),
        SizedBox(
          height: 40.0,
        ),
        _topContainer(),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          child: _redeemCounterContainer(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          child: _confirmButtonContainer(context),
        ),
      ],
    );
  }

  Widget _titleContainer() {
    return Container(
      child: Text(
        'Konfirmasi Penukaran',
        style: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _topContainer() {
    return Container(
      child: Text(
        'Berapa banyak ${args.itemName} yang ingin ditukar?',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  int totalItem = 0;

  Widget _redeemCounterContainer() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 15.0,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        color: Colors.grey[200],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
                color: Colors.green,
              ),
              child: Icon(
                Icons.remove,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            onTap: () {
              setState(() {
                if (totalItem > 0) totalItem--;
              });
            },
          ),
          Container(
            child: Text(
              '$totalItem',
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
                color: Colors.green,
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            onTap: () {
              setState(() {
                if (((args.poin / args.reqPoin).floor()) > totalItem)
                  totalItem++;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _confirmButtonContainer(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10.0,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          color: Colors.green,
        ),
        child: Text(
          'Tukar',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      onTap: () {
        if ((args.poin / args.reqPoin).round() >= totalItem) {
          context.bloc<InvoiceBloc>().add(
                PostInvoice(
                  args.userId,
                  args.rewardId,
                  totalItem.toString(),
                ),
              );
        } else if (totalItem == 0) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('Total item yang ditukar harus minimal 1'),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

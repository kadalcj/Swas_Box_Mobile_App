import 'package:bank_sampah_mobile/bloc/take_bg/take_bg_bloc.dart';
import 'package:bank_sampah_mobile/repository/measure_repository.dart';
import 'package:bank_sampah_mobile/screen/widget/circular_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class SavingPage extends StatefulWidget {
  @override
  _SavingPageState createState() => _SavingPageState();
}

class _SavingPageState extends State<SavingPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrCodeText = '';
  QRViewController qrViewController;

  // Context
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider<TakeBgBloc>(
        create: (context) => TakeBgBloc(MeasureRepository()),
        child: SafeArea(
          child: BlocConsumer<TakeBgBloc, TakeBgState>(
            listener: (context, state) {
              if (state is TakeBgIsLoaded) {
                Navigator.pushNamed(context, '/savingConfirm',
                    arguments: qrCodeText);
              } else if (state is TakeBgIsError) {
                // DEV
                print(state.message);

                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Terjadi Kesalahan'),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is TakeBgInitial) {
                return _initPage(context);
              } else if (state is TakeBgIsLoading) {
                return Center(
                  child: CircularContainer(
                    title: 'Memproses',
                  ),
                );
              }

              return _initPage(context);
            },
          ),
        ),
      ),
    );
  }

  Widget _initPage(BuildContext context) {
    _context = context;

    return Container(
      child: Column(
        children: [
          _scannerContainer(context),
          _actionContainer(),
        ],
      ),
    );
  }

  Widget _scannerContainer(BuildContext context) {
    return Expanded(
      child: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }

  void _onQRViewCreated(QRViewController qrViewController) {
    this.qrViewController = qrViewController;
    qrViewController.scannedDataStream.listen(
      (scanData) {
        setState(
          () {
            qrCodeText = scanData;

            qrViewController.pauseCamera();

            _context.bloc<TakeBgBloc>().add(TakeBg(qrCodeText));
          },
        );
      },
    );
  }

  Widget _actionContainer() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
      child: Column(
        children: [
          Text(
            'Petunjuk',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.green,
                  ),
                  child: SvgPicture.asset(
                    'assets/qr_code_icon.svg',
                    width: 100.0,
                    height: 100.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(
                    'Scan Barcode Yang Terdapat Pada Mesin Yang Tersedia!',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    qrViewController?.dispose();

    super.dispose();
  }
}

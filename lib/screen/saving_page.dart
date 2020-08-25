import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            children: [
              _scannerContainer(),
              _actionContainer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _scannerContainer() {
    // return Expanded(
    //   child: Container(
    //     color: Colors.green,
    //   ),
    // );
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

            showDialog(
              context: context,
              child: _processSavingContainer(),
            );
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

  Widget _processSavingContainer() {
    return AlertDialog(
      content: Container(
        width: double.infinity,
        child: Wrap(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 5.0,
              ),
              child: Text(
                'Selanjutnya...',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: Text(
                'Letakkan botol atau kaleng pada mesin sesuai dengan tempat yang sudah ditandai atau seperti pada gambar dibawah ini.',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              height: 300.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.green,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Jika sudah, silahkan tekan tombol dibawah untuk melanjutkan proses menabung.",
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10.0,
              ),
              child: InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.green,
                  ),
                  child: Text(
                    'Lanjut',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  qrViewController.resumeCamera();

                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    qrViewController?.dispose();
    super.dispose();
  }
}

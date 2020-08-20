import 'package:flutter/material.dart';

class SavingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            top: 20.0,
            left: 20.0,
            right: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleContainer(),
              Expanded(
                child: _stepByContainer(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                child: _buttonSave(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleContainer() {
    return Container(
      child: Column(
        children: [
          Text(
            'Selanjutnya...',
            style: TextStyle(
              fontSize: 38.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 11.0,
          ),
        ],
      ),
    );
  }

  Widget _stepByContainer() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Letakkan Botol atau Kaleng Pada Mesin',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            'Letakkan botol atau kaleng pada mesin sesuai dengan tempat yang sudah ditandai atau seperti pada gambar dibawah ini.',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 350.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(8.0),
              color: Colors.green,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "Jika sudah, silahkan tekan tombol 'Menabung' dibawah untuk melanjutkan proses menabung.",
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonSave() {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 11.0,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(8.0),
          color: Colors.green,
        ),
        child: Text(
          'Menabung',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      onTap: () {
        // TODO: Request to measure the object
      },
    );
  }
}

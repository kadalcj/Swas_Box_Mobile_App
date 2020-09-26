import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bank_sampah_mobile/model/measure.dart';
import 'package:bank_sampah_mobile/bloc/measure/measure_bloc.dart';
import 'package:bank_sampah_mobile/repository/measure_repository.dart';
import 'package:bank_sampah_mobile/repository/trash_repository.dart';

import 'package:bank_sampah_mobile/screen/widget/circular_container.dart';

class SavingConfirmationPage extends StatefulWidget {
  final String args;

  const SavingConfirmationPage({Key key, this.args}) : super(key: key);

  @override
  _SavingConfirmationPageState createState() =>
      _SavingConfirmationPageState(args);
}

class _SavingConfirmationPageState extends State<SavingConfirmationPage> {
  final String args;

  _SavingConfirmationPageState(this.args);

  // Post Measure Params
  bool isCan;
  int poin;
  String trashName;

  // Prefs
  String userId;

  Future _initPrefs() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    setState(() {
      this.userId = _prefs.getString('_id');
    });
  }

  @override
  void initState() {
    super.initState();

    _initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MeasureBloc>(
      create: (context) => MeasureBloc(MeasureRepository(), TrashRepository()),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            child: BlocConsumer<MeasureBloc, MeasureState>(
              listener: (context, state) {
                if (state is MeasureIsLoaded) {
                  final data = state.measure;

                  // Set Data Before Push
                  _setPushData(data);

                  // Push Data
                  context.bloc<MeasureBloc>().add(PostMeasure(
                      userId, isCan.toString(), poin.toString(), trashName));
                } else if (state is MeasureIsPostLoaded) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home',
                    ModalRoute.withName('/'),
                  );
                } else if (state is MeasureIsError) {
                  print(state.message);
                }
              },
              builder: (context, state) {
                if (state is MeasureIsLoading) {
                  return Center(
                    child: CircularContainer(
                      title: 'Menghitung Poin',
                    ),
                  );
                } else if (state is MeasureIsPostLoading) {
                  return Center(
                    child: CircularContainer(
                      title: 'Menyimpan Data',
                    ),
                  );
                }

                return _initPage(context);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _initPage(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selanjutnya....',
            style: TextStyle(
              fontSize: 38.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Letakkan botol atau kaleng pada mesin sesuai dengan tempat yang sudah ditandai atau seperti pada gambar dibawah ini.',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            width: double.infinity,
            height: 300.0,
            child: Image(
              image: AssetImage(
                'assets/instruction_image.jpeg',
              ),
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'Jika sudah, silahkan tekan tombol dibawah untuk melanjutkan proses menabung.',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 20.0,
          ),
          InkWell(
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
              context.bloc<MeasureBloc>().add(GetMeasure(args));
            },
          ),
        ],
      ),
    );
  }

  // Widget _showDialog() {
  //   showDialog(
  //     context: context,
  //     child: AlertDialog(
  //       content: Wrap(
  //         children: [
  //           Container(
  //             width: double.infinity,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Container(
  //                   padding: EdgeInsets.all(
  //                     10.0,
  //                   ),
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.all(Radius.circular(180.0)),
  //                     color: Colors.green,
  //                   ),
  //                   child: Icon(
  //                     Icons.check,
  //                     size: 200.0,
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 30.0,
  //                 ),
  //                 Text(
  //                   'Sukses',
  //                   style: TextStyle(
  //                     fontSize: 24.0,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  void _setPushData(Measure measure) {
    bool isCan = measure.results.isCan;
    double height = measure.results.height.toDouble();

    // Check if is it can or not
    if (isCan) {
      setState(() {
        this.isCan = true;
        this.poin = 3;
        this.trashName = 'Kaleng';
      });
    } else {
      /// Botol Kecil ?? (Belum Tahu). Anggap Saja 14.5cm, Jika dibawah 17.0cm Maka Botol Kecil
      /// Botol Sedang 22.7cm, Jika Diantara 17.0cm dan 28.0cm Maka Botol Sedang
      /// Botol Besar 31.5cm, Jika diatas 28.0cm Maka Botol Besar
      if (height < 18.0) {
        setState(() {
          this.isCan = false;
          this.poin = 1;
          this.trashName = 'Botol Kecil';
        });
      } else if (height > 18.0 && height < 26.0) {
        setState(() {
          this.isCan = false;
          this.poin = 2;
          this.trashName = 'Botol Sedang';
        });
      } else {
        setState(() {
          this.isCan = false;
          this.poin = 3;
          this.trashName = 'Botol Besar';
        });
      }
    }
  }
}

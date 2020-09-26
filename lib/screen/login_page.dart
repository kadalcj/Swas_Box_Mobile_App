import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:bank_sampah_mobile/bloc/login/login_bloc.dart';
import 'package:bank_sampah_mobile/repository/user_repository.dart';

import 'package:bank_sampah_mobile/screen/widget/title_container.dart';
import 'package:bank_sampah_mobile/screen/widget/circular_container.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  DateTime currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: WillPopScope(
          child: BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(UserRepository()),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginIsLoaded) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/home',
                          ModalRoute.withName('/'),
                        );
                      } else if (state is LoginError) {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is LoginInitial) {
                        return _initialPage(context);
                      } else if (state is LoginIsLoading) {
                        return CircularContainer(title: 'Mohon Tunggu');
                      }

                      return _initialPage(context);
                    },
                  ),
                ),
              ),
            ),
          ),
          onWillPop: onWillPop,
        ),
      ),
    );
  }

  Widget _initialPage(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleContainer(),
        _formContainer(context),
        _registerContainer(context),
      ],
    );
  }

  Widget _formContainer(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'contoh@mail.com',
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Data Ini Tidak Boleh Kosong';
                  } else if (!validateEmail(value)) {
                    return 'Format Email Salah';
                  }

                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                obscureText: true,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Data Ini Tidak Boleh Kosong';
                  } else if (value.length < 6) {
                    return 'Password Minimal 6 Karakter';
                  }

                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 14.0,
              ),
              child: InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 11.0,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.green),
                  child: Text(
                    'Masuk',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    context.bloc<LoginBloc>().add(
                          PostLogin(
                            _emailController.text,
                            _passwordController.text,
                          ),
                        );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _registerContainer(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 11.0,
          ),
          Text(
            'Belum Memiliki Akun?',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Colors.green,
                  width: 3.0,
                ),
                color: Colors.white,
              ),
              child: Text(
                'Daftar',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/register',
              );
            },
          ),
        ],
      ),
    );
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;

      Fluttertoast.showToast(msg: 'Tekan sekali lagi untuk keluar');

      return Future.value(false);
    }

    return Future.value(true);
  }

  @override
  void dispose() {
    _emailController?.dispose();
    _passwordController?.dispose();

    super.dispose();
  }
}

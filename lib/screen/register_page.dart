import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bank_sampah_mobile/bloc/register/register_bloc.dart';
import 'package:bank_sampah_mobile/repository/user_repository.dart';

import 'package:bank_sampah_mobile/screen/widget/title_container.dart';
import 'package:bank_sampah_mobile/screen/widget/circular_container.dart';

class RegisterPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _contactController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
        body: BlocProvider(
          create: (context) => RegisterBloc(UserRepository()),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: BlocConsumer<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterIsLoaded) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Akun Berhasil Terdaftar'),
                        ),
                      );
                    } else if (state is RegisterError) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is RegisterInitial) {
                      return _initialPage(context);
                    } else if (state is RegisterIsLoading) {
                      return CircularContainer(title: 'Mendaftarkan');
                    }
                    return _initialPage(context);
                  },
                ),
              ),
            ),
          ),
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
        _loginContainer(context),
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
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nama Depan',
                  hintText: 'Ilham Wahyu',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Data Ini Tidak Boleh Kosong';
                  }

                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nama Belakang',
                  hintText: 'Analta',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Data Ini Tidak Boleh Kosong';
                  }

                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                controller: _contactController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nomor Handphone',
                  hintText: '08XXXXXXXXXX',
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Data Ini Tidak Boleh Kosong';
                  }

                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
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
                  }

                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14.0),
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
                    'Daftar',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    context.bloc<RegisterBloc>().add(
                          PostRegister(
                            _firstNameController.text,
                            _lastNameController.text,
                            _contactController.text,
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

  Widget _loginContainer(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 11.0,
          ),
          Text(
            'Sudah Memiliki Akun?',
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
                'Masuk',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: 25.0,
          ),
        ],
      ),
    );
  }

  // Email RegEx
  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }
}

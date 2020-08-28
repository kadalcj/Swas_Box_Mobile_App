import 'package:bank_sampah_mobile/screen/redeem_confirmation_page.dart';
import 'package:bank_sampah_mobile/screen/redeem_page.dart';
import 'package:flutter/material.dart';

import 'package:bank_sampah_mobile/screen/landing_page.dart';
import 'package:bank_sampah_mobile/screen/login_page.dart';
import 'package:bank_sampah_mobile/screen/register_page.dart';
import 'package:bank_sampah_mobile/screen/home_page.dart';
import 'package:bank_sampah_mobile/screen/saving_page.dart';
import 'package:bank_sampah_mobile/screen/saving_detail_page.dart';
import 'package:bank_sampah_mobile/config/router/error_route_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => LandingPage());
      case '/login':
        return MaterialPageRoute(builder: (context) => LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (context) => RegisterPage());
      case '/home':
        return MaterialPageRoute(builder: (context) => HomePage());
      case '/saving':
        return MaterialPageRoute(builder: (context) => SavingPage());
      case '/savingDetail':
        return MaterialPageRoute(builder: (context) => SavingDetailPage());
      case '/redeem':
        return MaterialPageRoute(builder: (context) => RedeemPage());
      case '/rewardConfirm':
        var args = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => RedeemConfirmationPage(
            args: args,
          ),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) => ErrorRoutePage());
  }
}

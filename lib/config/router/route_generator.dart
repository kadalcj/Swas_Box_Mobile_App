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
        return MaterialPageRoute(builder: (_) => LandingPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/saving':
        return MaterialPageRoute(builder: (_) => SavingPage());
      case '/savingDetail':
        return MaterialPageRoute(builder: (_) => SavingDetailPage());
      case '/redeem':
        return MaterialPageRoute(builder: (_) => RedeemPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) => ErrorRoutePage());
  }
}

import 'package:avestan_test/UI/screens/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'UI/screens/settings.dart';

class Routes {
  static Route? onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (context) => HomePage());

      case '/settings':
        return MaterialPageRoute(builder: (context) => Settings());
      default:
    }
  }
}

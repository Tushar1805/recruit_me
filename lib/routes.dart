import 'package:avestan_test/UI/screens/home_page.dart';
import 'package:avestan_test/UI/screens/payments.dart';
import 'package:avestan_test/logic/jobs_cubit/jobs_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'UI/screens/settings.dart';

class Routes {
  static Route? onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => JobsCubit(),
                  child: HomePage(),
                ));

      case '/payment':
        return MaterialPageRoute(builder: (context) => Payment());

      case '/settings':
        return MaterialPageRoute(builder: (context) => Settings());
      default:
    }
  }
}

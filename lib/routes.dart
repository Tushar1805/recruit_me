import 'package:avestan_test/UI/screens/apply_screen.dart';
import 'package:avestan_test/UI/screens/home_page.dart';
import 'package:avestan_test/UI/screens/payments.dart';
import 'package:avestan_test/UI/screens/view_job_applications.dart';
import 'package:avestan_test/logic/apply_jobs_cubit/apply_jobs_cubit.dart';
import 'package:avestan_test/logic/jobs_cubit/jobs_cubit.dart';
import 'package:avestan_test/logic/view_applications_cubit/view_applications_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'UI/screens/pdf_viewer_page.dart';
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

      case '/apply':
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => ApplyJobCubit(),
                  child: ApplyScreen(),
                ));

      case '/view':
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      ViewApplicationsCubit(docId: arguments["docId"]),
                  child: ViewJobApplications(),
                ));

      case '/pdf':
      Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (context) => PDFViewerPage(file : arguments['file']));

      case '/payment':
        return MaterialPageRoute(builder: (context) => Payment());

      case '/settings':
        return MaterialPageRoute(builder: (context) => Settings());
      default:
    }
  }
}

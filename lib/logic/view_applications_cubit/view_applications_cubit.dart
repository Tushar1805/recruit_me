import 'dart:io';

import 'package:avestan_test/data/models/application_model.dart';
import 'package:avestan_test/data/repositories/jobs_repository.dart';
import 'package:avestan_test/logic/view_applications_cubit/view_applications_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ViewApplicationsCubit extends Cubit<ViewApplicationsState> {
  final String? docId;
  ViewApplicationsCubit({this.docId}) : super(ViewApplicationsInitialState()) {
    getAllApplications();
  }

  final firestore = FirebaseFirestore.instance;
  final repository = JobsRepository();
  List<Application> applications = [];

  void getAllApplications() async {
    emit(ApplicationsLoadingState());
    applications = await repository.getAllApplications(uid: docId);
    emit(ApplicationsLoadedState());
  }

  static Future<File> loadNetWork(String url) async {
    
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;

    return storeFile(url, bytes);
  }

  static Future<File> storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}

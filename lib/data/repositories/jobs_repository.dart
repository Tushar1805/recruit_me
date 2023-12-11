import 'dart:io';

import 'package:avestan_test/data/models/application_model.dart';
import 'package:avestan_test/data/models/job_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class JobsRepository {
  final firestore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;
  UploadTask? uploadTask;

  Future<void> postJob({
    required jobId,
    required title,
    required summary,
    required salary,
    required requirements,
    required skills,
    required deadline,
    required applications,
  }) async {
    await firestore.collection("jobs").add({
      "jobID": jobId,
      "title": title,
      "summary": summary,
      "salary": salary,
      "responsibility": "",
      "requirements": requirements,
      "Skills": skills,
      "deadline": deadline,
      "applications": [],
    });
  }

  //? Action : 0 - No Action, 1 - Rejected
  //? Status: 0 - Pending, 1- inProgress, 2 - Approve
  Future<void> applyToJob({
    required uid,
    required name,
    required email,
    required cv,
  }) async {
    await firestore.collection("jobs").doc(uid).update({
      "applications": FieldValue.arrayUnion([
        {
          "name": name,
          "email": email,
          "cv": cv,
          "interviewer": "",
          "status": 0,
          "action": 0
        }
      ])
    });
  }

  Future<String?> uploadFile(PlatformFile pickedFile) async {
    final path = "cv/${pickedFile.name}";
    final file = File(pickedFile.path!);

    final ref = firebaseStorage.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() => {});

    final url = await snapshot.ref.getDownloadURL();

    print("Download Link: $url");
    return url;
  }

  Future<List<Job>> getAllJobs() async {
    return (await firestore
            .collection('jobs')
            .orderBy("deadline", descending: false)
            .get())
        .docs
        .map((item) => Job.fromJson(item.data()))
        .toList();
  }

  Future<List<String>> getAllJobsUid() async {
    List<String> list = [];
    await firestore
        .collection('jobs')
        .orderBy("deadline", descending: false)
        .get()
        .then((value) => value.docs.forEach((element) {
              list.add(element.id);
            }));
    return list;
  }

  Future<List<Application>> getAllApplications({required uid}) async {
    DocumentSnapshot doc = await firestore.collection('jobs').doc(uid).get();
    Map<String, dynamic>? m = doc.data();

    return List<Application>.generate(
        doc.data()!["applications"].length,
        (int index) =>
            Application.fromJson(doc.data()!["applications"].elementAt(index)));
  }
}

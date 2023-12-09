import 'package:cloud_firestore/cloud_firestore.dart';

class JobsRepository {
  final firestore = FirebaseFirestore.instance;

  Future<void> postJob({
    required jobId,
    required title,
    required summary,
    required responsibility,
    required requirements,
    required skills,
    required deadline,
    required applications,
  }) async {
    await firestore.collection("jobs").add({
      "jobID": jobId,
      "title": title,
      "summary": summary,
      "responsibility": responsibility,
      "requirements": requirements,
      "Skills": skills,
      "deadline": deadline,
      "applications": [],
    });
  }
}

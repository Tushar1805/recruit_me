import 'package:avestan_test/data/models/job_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JobsRepository {
  final firestore = FirebaseFirestore.instance;

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

  Future<List<Job>> getAllJobs() async {
    return (await firestore
            .collection('jobs')
            .orderBy("deadline", descending: false)
            .get())
        .docs
        .map((item) => Job.fromJson(item.data()))
        .toList();
  }
}

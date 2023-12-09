import 'dart:convert';

import 'application_model.dart';

Job jobFromJson(String str) => Job.fromJson(json.decode(str));

String jobToJson(Job data) => json.encode(data.toJson());

class Job {
  final String jobId;
  final String title;
  final String summary;
  final String responsibility;
  final String requirements;
  final String skills;
  final String deadline;
  final List<Application> applications;

  Job({
    required this.jobId,
    required this.title,
    required this.summary,
    required this.responsibility,
    required this.requirements,
    required this.skills,
    required this.deadline,
    required this.applications,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        jobId: json["jobID"],
        title: json["title"],
        summary: json["summary"],
        responsibility: json["responsibility"],
        requirements: json["requirements"],
        skills: json["Skills"],
        deadline: json["deadline"],
        applications: List<Application>.from(
            json["applications"].map((x) => Application.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "jobID": jobId,
        "title": title,
        "summary": summary,
        "responsibility": responsibility,
        "requirements": requirements,
        "Skills": skills,
        "deadline": deadline,
        "applications": List<dynamic>.from(applications.map((x) => x.toJson())),
      };
}

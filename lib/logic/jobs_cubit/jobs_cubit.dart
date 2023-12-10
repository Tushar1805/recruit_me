import 'package:avestan_test/data/models/job_model.dart';
import 'package:avestan_test/data/repositories/jobs_repository.dart';
import 'package:avestan_test/logic/jobs_cubit/jobs_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class JobsCubit extends Cubit<JobsState> {
  DateTime selectedDate = DateTime.now();
  JobsCubit() : super(JobsInitialState()) {
    getAllJobs();
  }

  final repository = JobsRepository();
  List<Job>? jobs;
  List<String>? jobsUid;

  //* Post Job Form Variables
  String? jobId;
  String? title;
  String? summary;
  String? salary;
  String? requirements;
  String? skills;
  String? deadline;

  //* Post form Job Setters
  void postFormIDChange(id) {
    this.jobId = id;
  }

  void postFormTitleChange(title) {
    this.title = title;
  }

  void postFormSummaryChange(summary) {
    this.summary = summary;
  }

  void postFormRequirementChange(requirements) {
    this.requirements = requirements;
  }

  void postFormSalaryChange(salary) {
    this.salary = salary;
  }

  void postFormSkillChange(skills) {
    this.skills = skills;
  }

  void postFormDeadlineChange(deadline) {
    this.deadline = deadline;
  }

  //* Post form Job Validator
  void postFormValidate({
    required jobId,
    required title,
    required summary,
    required salary,
    required requirements,
    required skills,
    required deadline,
  }) {
    if (jobId == "") {
      emit(JobsPostFormErrorState("Please Enter the job ID"));
    } else if (title == "") {
      emit(JobsPostFormErrorState("Please Enter the title"));
    } else if (summary == "") {
      emit(JobsPostFormErrorState("Please Enter the summary"));
    } else if (salary == "") {
      emit(JobsPostFormErrorState("Please Enter the salary"));
    } else if (requirements == "") {
      emit(JobsPostFormErrorState("Please Enter the requirements"));
    } else if (skills == "") {
      emit(JobsPostFormErrorState("Please Enter the skills"));
    } else if (deadline == "") {
      emit(JobsPostFormErrorState("Please Enter the deadline"));
    } else {
      emit(JobsPostFormValidState());
    }
  }

  void clearAll() {
    jobId = "";
    title = "";
    summary = "";
    salary = "";
    requirements = "";
    skills = "";
    deadline = "";
    emit(JobsInitialState());
  }

  Future<void> selectDate(BuildContext context, controller) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) selectedDate = picked;
    controller.value = TextEditingValue(
        text: DateFormat("dd-MM-yyyy").format(picked!).toString());
    print("Date: " + controller.text.toString());
    postFormDeadlineChange(controller.text.toString());
    postFormValidate(
        jobId: jobId,
        title: title,
        summary: summary,
        salary: salary,
        requirements: requirements,
        skills: skills,
        deadline: deadline);
  }

//* Post Job to the database
  Future<void> postjob() async {
    emit(JobsPostSubmittingState());
    await repository.postJob(
        jobId: jobId,
        title: title,
        summary: summary,
        salary: salary,
        requirements: requirements,
        skills: skills,
        deadline: deadline,
        applications: []);
    await getAllJobs();
    emit(JobsPostedState());
  }

  Future<void> getAllJobs() async {
    emit(JobsPostFetchingState());
    jobs = await repository.getAllJobs();
    jobsUid = await repository.getAllJobsUid();
    emit(JobsPostFetchedState());
  }
}

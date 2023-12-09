import 'package:avestan_test/data/models/job_model.dart';
import 'package:avestan_test/data/repositories/jobs_reposittory.dart';
import 'package:avestan_test/logic/jobs_cubit/jobs_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class JobsCubit extends Cubit<JobsState> {
  DateTime selectedDate = DateTime.now();
  JobsCubit() : super(JobsInitialState());

  final repository = JobsRepository();

  List<Job>? jobs;
  String? jobId;
  String? title;
  String? summary;
  String? responsibility;
  String? requirements;
  String? skills;
  String? deadline;

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

  void postFormResponsibilityChange(responsibility) {
    this.responsibility = responsibility;
  }

  void postFormSkillChange(skills) {
    this.skills = skills;
  }

  void postFormDeadlineChange(deadline) {
    this.deadline = deadline;
  }

  void postFormValidate({
    required jobId,
    required title,
    required summary,
    required responsibility,
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
    } else if (responsibility == "") {
      emit(JobsPostFormErrorState("Please Enter the responsibility"));
    } else if (requirements == "") {
      emit(JobsPostFormErrorState("Please Enter the requirements"));
    } else if (skills == "") {
      emit(JobsPostFormErrorState("Please Enter the skills"));
    } else if (deadline == "" || deadline == null) {
      emit(JobsPostFormErrorState("Please Enter the deadline"));
    } else {
      emit(JobsPostFormValidState());
    }
  }

  void clearAll() {
    jobId = "";
    title = "";
    summary = "";
    responsibility = "";
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
        responsibility: responsibility,
        requirements: requirements,
        skills: skills,
        deadline: deadline);
  }

  Future<void> postjob() async {
    emit(JobsPostSubmittingState());
    await repository.postJob(
        jobId: jobId,
        title: title,
        summary: summary,
        responsibility: responsibility,
        requirements: requirements,
        skills: skills,
        deadline: deadline,
        applications: []);
    emit(JobsPostedState());
  }
}

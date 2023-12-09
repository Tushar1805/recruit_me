import 'package:avestan_test/data/models/job_model.dart';
import 'package:avestan_test/data/repositories/jobs_repository.dart';
import 'package:avestan_test/logic/jobs_cubit/jobs_states.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
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

  //* Apply Job Form Variables
  String? name;
  String? email;
  String? cv;
  PlatformFile? pickedFile;

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

  //* Apply Job Setters
  void applyNameChange(name) {
    this.name = name;
  }

  void applyEmailChange(email) {
    this.email = email;
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

  //* Apply Job Form Validator
  void applyFormValidate({required name, required email, required cv}) {
    if (name == "") {
      emit(JobsApplyFormErrorState("Please Enter the name"));
    } else if (email != "" && EmailValidator.validate(email) == false) {
      emit(JobsApplyFormErrorState("Please Enter a valid email"));
    } else if (cv == "") {
      emit(JobsApplyFormErrorState("Please Enter the CV"));
    } else {
      emit(JobsApplyFormValidState());
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

  void clearApply() {
    name = "";
    email = "";
    cv = "";
    pickedFile = null;
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

  //* Upload CV functionality
  Future<void> selectFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      pickedFile = result!.files.first;
      await uploadFile();
      // emit(JobsFileUploadedState(pickedFile!));
    } catch (e) {
      throw "Error: Uploading the file: ${e.toString()}";
    }
  }

  Future<void> uploadFile() async {
    cv = await repository.uploadFile(pickedFile!);
    applyFormValidate(name: name, email: email, cv: cv);
  }

  void cancelFileSelection() {
    cv = "";
    pickedFile = null;
    emit(state);
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

  //* Post Job application to the database
  Future<void> applyToJob({required uid}) async {
    emit(JobsApplySubmittingState());
    await repository.applyToJob(uid: uid, name: name, email: email, cv: cv);
    emit(JobsAppliedState());
  }

  Future<void> getAllJobs() async {
    emit(JobsPostFetchingState());
    jobs = await repository.getAllJobs();
    jobsUid = await repository.getAllJobsUid();
    emit(JobsPostFetchedState());
  }
}

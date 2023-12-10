import 'package:avestan_test/data/models/job_model.dart';
import 'package:avestan_test/data/repositories/jobs_repository.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'apply_jobs_state.dart';

class ApplyJobCubit extends Cubit<ApplyJobState> {
  ApplyJobCubit() : super(ApplyJobInitialState()) {
    clearApply();
    getAllJobs();
  }

  final repository = JobsRepository();
  List<Job>? jobs;
  List<String>? jobsUid;

  //* Apply Job Form Variables
  String? name;
  String? email;
  String? cv;
  PlatformFile? pickedFile;

  //* Apply Job Setters
  void applyNameChange(name) {
    this.name = name;
  }

  void applyEmailChange(email) {
    this.email = email;
  }

  //* Apply Job Form Validator
  void applyFormValidate({required name, required email, required cv}) {
    if (name == "") {
      emit(JobApplyFormErrorState("Please Enter the name"));
    } else if (email == "" || EmailValidator.validate(email) == false) {
      emit(JobApplyFormErrorState("Please Enter a valid email"));
    } else if (cv == "") {
      emit(JobApplyFormErrorState("Please Upload the CV"));
    } else {
      emit(JobApplyFormValidState());
    }
  }

  void clearApply() {
    name = "";
    email = "";
    cv = "";
    pickedFile = null;
  }

  //* Upload CV functionality
  Future<void> selectFile() async {
    try {
      emit(JobFileUploadingState());
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
    applyFormValidate(name: name, email: email, cv: cv);
  }

  //* Post Job application to the database
  Future<void> applyToJob({required uid}) async {
    emit(ApplyJobSubmittingState());
    await repository.applyToJob(uid: uid, name: name, email: email, cv: cv);
    emit(JobAppliedState());
  }

  Future<void> getAllJobs() async {
    emit(JobsFetchingState());
    jobs = await repository.getAllJobs();
    jobsUid = await repository.getAllJobsUid();
    emit(JobsFetchedState());
  }
}

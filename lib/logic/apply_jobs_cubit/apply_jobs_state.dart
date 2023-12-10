import 'package:file_picker/file_picker.dart';

abstract class ApplyJobState {}

class ApplyJobInitialState extends ApplyJobState{}

class ApplyJobSubmittingState extends ApplyJobState {}

class JobAppliedState extends ApplyJobState {}

class JobFileUploadingState extends ApplyJobState{}

class JobFileUploadedState extends ApplyJobState {
  final PlatformFile file;
  JobFileUploadedState(this.file);
}

class JobApplyFormErrorState extends ApplyJobState {
  final String errorMessage;
  JobApplyFormErrorState(this.errorMessage);
}

class JobApplyFormValidState extends ApplyJobState {}

class JobsFetchingState extends ApplyJobState{}

class JobsFetchedState extends ApplyJobState{}
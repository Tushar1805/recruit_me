import 'package:file_picker/file_picker.dart';

abstract class JobsState {}

abstract class ApplyJobState extends JobsState{}

class JobsInitialState extends JobsState {}

class JobsLoadingState extends JobsState {}

class JobsPostSubmittingState extends JobsState {}

class JobsPostedState extends JobsState {}

class JobsPostFetchingState extends JobsState {}

class JobsPostFetchedState extends JobsState {}

class JobsPostFormValidState extends JobsState {}
class JobsPostFormErrorState extends JobsState {
  final String errorMessage;
  JobsPostFormErrorState(this.errorMessage);
}

class JobsApplySubmittingState extends ApplyJobState {}

class JobsAppliedState extends ApplyJobState {}

class JobsFileUploadedState extends ApplyJobState {
  final PlatformFile file;
  JobsFileUploadedState(this.file);
}

class JobsApplyFormErrorState extends ApplyJobState {
  final String errorMessage;
  JobsApplyFormErrorState(this.errorMessage);
}

class JobsApplyFormValidState extends ApplyJobState {}

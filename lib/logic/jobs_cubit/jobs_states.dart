abstract class JobsState {}

class JobsInitialState extends JobsState {}

class JobsLoadingState extends JobsState {}

class JobsPostSubmittingState extends JobsState {}

class JobsPostedState extends JobsState{}

class JobsPostFetchingState extends JobsState {}
class JobsPostFetchedState extends JobsState {}

class JobsPostFormValidState extends JobsState {}

class JobsPostFormErrorState extends JobsState {
  final String errorMessage;
  JobsPostFormErrorState(this.errorMessage);
}
// class JobsLoadingState extends JobsState{}
import 'package:avestan_test/Constants/constants.dart';
import 'package:avestan_test/Constants/utils.dart';
import 'package:avestan_test/logic/jobs_cubit/jobs_cubit.dart';
import 'package:avestan_test/logic/jobs_cubit/jobs_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostJob extends StatelessWidget {
  DateTime selectedDate = DateTime.now();
  static TextEditingController jobIdController = TextEditingController();
  static TextEditingController titleController = TextEditingController();
  static TextEditingController summaryController = TextEditingController();
  static TextEditingController responsibilityController =
      TextEditingController();
  static TextEditingController requirementController = TextEditingController();
  static TextEditingController skillsController = TextEditingController();
  static TextEditingController deadlineController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = BlocProvider.of<JobsCubit>(context);

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text("Add Job", style: headingStyle()),
            ),
            SizedBox(
              height: 15,
            ),
            BlocBuilder<JobsCubit, JobsState>(
              builder: (context, state) {
                if (state is JobsPostFormErrorState) {
                  return Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      state.errorMessage,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
            textFieldName(name: "Job ID", compulsory: true),
            SizedBox(
              height: 10,
            ),
            textField(
                width: width * 0.6,
                height: 50,
                controller: jobIdController,
                label: "Job ID",
                hint: 'Enter Job ID',
                lines: 1,
                provider: provider,
                fun: provider.postFormIDChange,
                initValue: provider.jobId),
            SizedBox(height: 15),
            textFieldName(name: "Title", compulsory: true),
            SizedBox(
              height: 10,
            ),
            textField(
                width: width,
                height: 50,
                controller: titleController,
                label: "Title",
                hint: 'Enter Title',
                lines: 1,
                provider: provider,
                fun: provider.postFormTitleChange,
                initValue: provider.title),
            SizedBox(height: 15),
            textFieldName(name: "Summary", compulsory: true),
            SizedBox(
              height: 10,
            ),
            textField(
                width: width,
                height: 50,
                controller: summaryController,
                label: "Summary",
                hint: 'Enter Summary',
                lines: 2,
                provider: provider,
                fun: provider.postFormSummaryChange,
                initValue: provider.summary),
            SizedBox(height: 10),
            textFieldName(name: "Responsibility", compulsory: true),
            SizedBox(
              height: 10,
            ),
            textField(
                width: width,
                height: 50,
                controller: responsibilityController,
                label: "Responsibility",
                hint: 'Enter Responsibility',
                lines: 2,
                provider: provider,
                fun: provider.postFormResponsibilityChange,
                initValue: provider.responsibility),
            SizedBox(height: 10),
            textFieldName(name: "Requirement", compulsory: true),
            SizedBox(
              height: 10,
            ),
            textField(
                width: width,
                height: 50,
                controller: requirementController,
                label: "Requirement",
                hint: 'Enter Requirement',
                lines: 1,
                provider: provider,
                fun: provider.postFormRequirementChange,
                initValue: provider.requirements),
            SizedBox(height: 10),
            textFieldName(name: "Skills", compulsory: true),
            SizedBox(
              height: 10,
            ),
            textField(
                width: width,
                height: 50,
                controller: skillsController,
                label: "Skills",
                hint: 'Enter Skills',
                lines: 1,
                provider: provider,
                fun: provider.postFormSkillChange,
                initValue: provider.skills),
            SizedBox(height: 10),
            textFieldName(name: "Deadline", compulsory: true),
            SizedBox(
              height: 10,
            ),
            Container(
              width: width,
              // height: MediaQuery.of(context).size.height * 0.07,
              child: GestureDetector(
                onTap: () => provider.selectDate(context, deadlineController),
                child: AbsorbPointer(
                  child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: mainColor5),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        controller: deadlineController,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Select Date",
                          suffixIcon: Icon(
                            Icons.calendar_today_outlined,
                            size: 18,
                            color: mainColor,
                          ),
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 15, top: 15, right: 15),
                        ),
                      )),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: BlocBuilder<JobsCubit, JobsState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () async {
                      if (state is JobsPostFormValidState) {
                        await provider.postjob();
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: width * 0.5,
                      height: height * 0.06,
                      decoration: ShapeDecoration(
                        color: (state is JobsPostFormValidState)
                            ? mainColor
                            : mainColor5,
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(width: 0.50, color: Color(0xFFD2D2D2)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: (state is JobsPostSubmittingState)
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              "Submit",
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: BlocBuilder<JobsCubit, JobsState>(
                builder: (context, state) {
                  if (state is JobsPostedState) {
                    return GestureDetector(
                      onTap: () async {
                        if (state is JobsPostedState) {
                          provider.clearAll();
                          jobIdController.clear();
                          titleController.clear();
                          summaryController.clear();
                          responsibilityController.clear();
                          requirementController.clear();
                          skillsController.clear();
                          deadlineController.clear();
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: width * 0.5,
                        height: height * 0.06,
                        decoration: ShapeDecoration(
                          color: (state is JobsPostedState)
                              ? mainColor
                              : mainColor5,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50, color: Color(0xFFD2D2D2)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Add Another Job",
                          style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 14,
                              color: Colors.white),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

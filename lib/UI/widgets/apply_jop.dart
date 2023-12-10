import 'package:avestan_test/Constants/constants.dart';
import 'package:avestan_test/Constants/utils.dart';
import 'package:avestan_test/logic/apply_jobs_cubit/apply_jobs_cubit.dart';
import 'package:avestan_test/logic/apply_jobs_cubit/apply_jobs_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplyToJob extends StatelessWidget {
  final String jobId;
  final String title;
  final String salary;
  final String skills;
  final String uid;
  const ApplyToJob(
      {Key? key,
      required jobId,
      required title,
      required salary,
      required skills,
      required uid})
      : jobId = jobId,
        title = title,
        salary = salary,
        skills = skills,
        uid = uid,
        super(key: key);
  static TextEditingController nameController = TextEditingController();
  static TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = BlocProvider.of<ApplyJobCubit>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          CardDialog(
            jobId: jobId,
            salary: salary,
            title: title,
            skills: skills,
            width: width,
            height: height,
            nameController: nameController,
            provider: provider,
            emailController: emailController,
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 40,
              height: 40,
              decoration: ShapeDecoration(
                color: mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: width * 0.2,
            child: BlocBuilder<ApplyJobCubit, ApplyJobState>(
              builder: (context, state) {
                if ((state is JobApplyFormValidState)) {
                  return GestureDetector(
                    child: Container(
                      width: width * 0.4,
                      height: height * 0.06,
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        "Apply",
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 14,
                            color: (state is JobApplyFormValidState)
                                ? Colors.white
                                : mainColor),
                      ),
                    ),
                    onTap: () => provider.applyToJob(uid: uid),
                  );
                } else if (state is ApplyJobSubmittingState) {
                  return Container(
                    width: width * 0.4,
                    height: height * 0.06,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      color: mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CardDialog extends StatelessWidget {
  const CardDialog({
    Key? key,
    required this.jobId,
    required this.salary,
    required this.title,
    required this.skills,
    required this.width,
    required this.height,
    required this.nameController,
    required this.provider,
    required this.emailController,
  }) : super(key: key);

  final String jobId;
  final String salary;
  final String title;
  final String skills;
  final double width;
  final double height;
  final TextEditingController nameController;
  final ApplyJobCubit provider;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.blue.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        margin: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20, right: 10, top: 20),
                  child: Text(
                    "#$jobId",
                    style: TextStyle(
                      color: mainColor7,
                      fontFamily: "Roboto",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: RichText(
                      text: TextSpan(
                        text: salary,
                        style: TextStyle(
                          color: mainColor,
                          fontFamily: "Roboto",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: " / Month",
                            style: TextStyle(
                              color: mainColor5,
                              fontFamily: "Roboto",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20, right: 10, top: 10),
              child: Text(
                title,
                style: jobTitleTextStyle(),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Text(
                skills,
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54),
              ),
            ),

            // textFieldName(name: "Name", compulsory: true),
            SizedBox(
              height: 10,
            ),
            BlocBuilder<ApplyJobCubit, ApplyJobState>(
              builder: (context, state) {
                if (state is JobApplyFormErrorState) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(bottom: 5, top: 5, left: 20),
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
            applyJobTextField(
                width: width,
                height: height * 0.08,
                controller: nameController,
                label: "Name",
                hint: 'Enter your name',
                lines: 1,
                provider: provider,
                fun: provider.applyNameChange,
                initValue: provider.name,
                type: TextInputType.name),
            SizedBox(
              height: 10,
            ),
            applyJobTextField(
              width: width,
              height: height * 0.08,
              controller: emailController,
              label: "Email",
              hint: 'Enter your email',
              lines: 1,
              provider: provider,
              fun: provider.applyEmailChange,
              initValue: provider.email,
              type: TextInputType.text,
            ),

            BlocBuilder<ApplyJobCubit, ApplyJobState>(
              builder: (context, state) {
                if (state is JobFileUploadedState ||
                    state is JobApplyFormValidState) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding:
                              EdgeInsets.only(bottom: 5, top: 10, left: 20),
                          child: Text(
                            provider.pickedFile!.name,
                            style: TextStyle(
                                color: mainColor,
                                fontFamily: "Roboto",
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => provider.cancelFileSelection(),
                        child: Container(
                          padding:
                              EdgeInsets.only(bottom: 5, top: 10, right: 20),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: Colors.red,
                                fontFamily: "Roboto",
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ],
                  );
                } else if (state is JobApplyFormErrorState) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(bottom: 10, top: 10, left: 20),
                    child: RichText(
                      text: TextSpan(
                          text: "Note:",
                          style: TextStyle(
                              color: mainColor,
                              fontFamily: "Roboto",
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                          children: [
                            TextSpan(
                              text: " Please upload only PDF file",
                              style: TextStyle(
                                  color: mainColor5,
                                  fontFamily: "Roboto",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            )
                          ]),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),

            BlocBuilder<ApplyJobCubit, ApplyJobState>(
              builder: (context, state) {
                if (state is JobFileUploadingState) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(bottom: 10, top: 10, left: 20),
                    child: Text(
                      "Uploading File.....",
                      style: TextStyle(
                          color: mainColor,
                          fontFamily: "Roboto",
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () => provider.selectFile(),
                    child: Container(
                      height: height * 0.05,
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          Text(
                            "Upload CV",
                            style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 14,
                                color: mainColor),
                          ),
                          Icon(
                            Icons.upload,
                            color: mainColor,
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),

            BlocListener<ApplyJobCubit, ApplyJobState>(
              listener: (context, state) {
                if (state is JobAppliedState) {
                  Navigator.of(context).pop();
                  nameController.clear();
                  emailController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Applied for the Job of $title",
                      style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 14,
                          color: Colors.white),
                    ),
                    backgroundColor: Colors.green,
                  ));
                  provider.clearApply();
                }
              },
              child: Container(),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}

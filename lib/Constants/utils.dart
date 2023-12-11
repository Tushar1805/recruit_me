import 'package:avestan_test/Constants/constants.dart';
import 'package:avestan_test/logic/apply_jobs_cubit/apply_jobs_cubit.dart';
import 'package:avestan_test/logic/jobs_cubit/jobs_cubit.dart';
import 'package:flutter/material.dart';

TextStyle headingStyle() {
  return TextStyle(
      fontFamily: "Roboto", fontSize: 20, fontWeight: FontWeight.bold);
}

TextStyle subHeadingStyle() {
  return TextStyle(
      fontFamily: "Roboto", fontSize: 16, fontWeight: FontWeight.bold);
}

TextStyle jobTitleTextStyle() {
  return TextStyle(
      fontFamily: "Roboto",
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: mainColor);
}

TextStyle jobSimpleTextStyle() {
  return TextStyle(
      fontFamily: "Roboto",
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.grey);
}

TextStyle jobDeadlineTextStyle() {
  return TextStyle(
      fontFamily: "Roboto",
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: mainColor7);
}

//* Home Page Decorations

ShapeDecoration activeTabShapeDecoration() {
  return ShapeDecoration(
    color: mainColor,
    shape: RoundedRectangleBorder(
      side: BorderSide(width: 0.50, color: Color(0xFFD2D2D2)),
      borderRadius: BorderRadius.circular(5),
    ),
  );
}

ShapeDecoration deactivatedTabShapeDecoration() {
  return ShapeDecoration(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      side: BorderSide(width: 0.50, color: mainColor),
      borderRadius: BorderRadius.circular(5),
    ),
  );
}

TextStyle activeTabTextStyle() {
  return TextStyle(
      fontFamily: 'Roboto',
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: Colors.white);
}

TextStyle deactivatedTabTextStyle() {
  return TextStyle(
      fontFamily: 'Roboto',
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: mainColor);
}

//* Form Decorations

TextStyle textFieldNameStyle() {
  return TextStyle(
      color: mainColor, fontFamily: "Roboto", fontWeight: FontWeight.w400);
}

RichText textFieldName({required String name, required bool compulsory}) {
  return RichText(
    text: TextSpan(
      text: name,
      style: textFieldNameStyle(),
      children: [
        TextSpan(
          text: compulsory ? " *" : "",
          style: TextStyle(color: Colors.red),
        ),
      ],
    ),
  );
}

Container textField(
    {required double width,
    required double height,
    required TextEditingController controller,
    required String label,
    required String hint,
    required int lines,
    required JobsCubit provider,
    required fun,
    required initValue,
    required TextInputType type}) {
  return Container(
    width: width,
    height: lines * height,
    child: TextFormField(
      onChanged: (val) {
        fun(val);
        provider.postFormValidate(
            jobId: provider.jobId,
            title: provider.title,
            summary: provider.summary,
            salary: provider.salary,
            requirements: provider.requirements,
            skills: provider.skills,
            deadline: provider.deadline);
      },
      maxLines: lines,
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: mainColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: mainColor),
        ),
        labelStyle: TextStyle(color: mainColor),
        border: OutlineInputBorder(),
        // labelText: label,
        hintText: hint,
        // contentPadding: EdgeInsets.only(
        //     left: 10, right: 10, top: lines * 5, bottom: lines * 5),
      ),
    ),
  );
}

//* Apply to job textfield
Container applyJobTextField(
    {required double width,
    required double height,
    required TextEditingController controller,
    required String label,
    required String hint,
    required int lines,
    required ApplyJobCubit provider,
    required fun,
    required initValue,
    required TextInputType type}) {
  return Container(
    width: width,
    height: lines * height,
    padding: EdgeInsets.only(left: 20, right: 20, top: 10),
    child: TextFormField(
      onChanged: (val) {
        fun(val);
        provider.applyFormValidate(
            name: provider.name, email: provider.email, cv: provider.cv);
      },
      maxLines: lines,
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: mainColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: mainColor),
        ),
        labelStyle: TextStyle(color: mainColor),
        border: OutlineInputBorder(),
        labelText: label,
        hintText: hint,
        contentPadding: EdgeInsets.only(left: 10, right: 10),
      ),
    ),
  );
}

//* View Job Applications Decorations

TextStyle normalVieWJobTextStyle(color) {
  return TextStyle(
    fontFamily: "Roboto",
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: color,
  );
}

Padding statusText({required text, required color}) {
  style(textcolor) => TextStyle(
        fontFamily: "Roboto",
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textcolor,
      );
  return Padding(
    padding: EdgeInsets.only(left: 20),
    child: RichText(
      text: TextSpan(
        text: "Status: ",
        style: style(Colors.grey),
        children: [
          TextSpan(
            text: text,
            style: style(color),
          ),
        ],
      ),
    ),
  );
}

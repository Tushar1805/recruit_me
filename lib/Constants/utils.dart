import 'package:avestan_test/Constants/constants.dart';
import 'package:avestan_test/logic/jobs_cubit/jobs_cubit.dart';
import 'package:flutter/material.dart';

TextStyle headingStyle() {
  return TextStyle(
      fontFamily: "roboto", fontSize: 20, fontWeight: FontWeight.bold);
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
  return TextStyle(color: Colors.black87, fontFamily: "Roboto");
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
    required initValue}) {
  return Container(
    width: width,
    height: lines * height,
    child: TextFormField(
      // initialValue: "Tushar",
      onChanged: (val) {
        fun(val);
        provider.postFormValidate(
            jobId: provider.jobId,
            title: provider.title,
            summary: provider.summary,
            responsibility: provider.responsibility,
            requirements: provider.requirements,
            skills: provider.skills,
            deadline: provider.deadline);
      },
      maxLines: lines,
      controller: controller,
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
      ),
    ),
  );
}

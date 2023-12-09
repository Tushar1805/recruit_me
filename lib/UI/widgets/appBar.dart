// import 'package:avestan_test/Constants/constants.dart';
import 'package:flutter/material.dart';

PreferredSize appBar({required Row row}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(60),
    child: Container(
      // color: mainColor3,
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(left: 10, right: 10),
      child: row,
    ),
  );
}

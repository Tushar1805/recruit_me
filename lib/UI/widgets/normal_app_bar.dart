import 'package:avestan_test/Constants/utils.dart';
import 'package:flutter/material.dart';

PreferredSize normalAppBar(BuildContext context, String title) {
  return PreferredSize(
    preferredSize: Size.fromHeight(50),
    child: Container(
      padding: EdgeInsets.only(right: 10, top: 20),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Flexible(
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: headingStyle(),
                  )))
        ],
      ),
    ),
  );
}

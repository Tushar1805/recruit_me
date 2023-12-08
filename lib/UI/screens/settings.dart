import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios_new),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Settings",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: ShapeDecoration(
                        color: Color.fromRGBO(28, 79, 122, 0.1),
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(width: 0.50, color: Color(0xFFD2D2D2)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Change Email Address",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black54,
                    )
                  ]),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: ShapeDecoration(
                        color: Color.fromRGBO(28, 79, 122, 0.1),
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(width: 0.50, color: Color(0xFFD2D2D2)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Update Address",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black54,
                    )
                  ]),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: ShapeDecoration(
                        color: Color.fromRGBO(28, 79, 122, 0.1),
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(width: 0.50, color: Color(0xFFD2D2D2)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Icon(
                        Icons.upload_file_outlined,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Change Mobile ",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black54,
                    )
                  ]),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: ShapeDecoration(
                        color: Color.fromRGBO(28, 79, 122, 0.1),
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(width: 0.50, color: Color(0xFFD2D2D2)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Icon(
                        Icons.admin_panel_settings_sharp,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Change Password",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black54,
                    )
                  ]),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: ShapeDecoration(
                        color: Color.fromRGBO(28, 79, 122, 0.1),
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(width: 0.50, color: Color(0xFFD2D2D2)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Icon(
                        Icons.settings,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Change MPin",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black54,
                    )
                  ]),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: ShapeDecoration(
                        color: Color.fromRGBO(28, 79, 122, 0.1),
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(width: 0.50, color: Color(0xFFD2D2D2)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Icon(
                        Icons.notifications_active_outlined,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Notification",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black54,
                    )
                  ]),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: ShapeDecoration(
                        color: Color.fromRGBO(28, 79, 122, 0.1),
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(width: 0.50, color: Color(0xFFD2D2D2)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Icon(
                        Icons.logout,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Logout",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black54,
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

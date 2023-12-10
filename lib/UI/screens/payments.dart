import 'dart:ui';
import 'package:avestan_test/Constants/constants.dart';
import 'package:avestan_test/Constants/utils.dart';
import 'package:avestan_test/UI/widgets/home_page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  // status
  // Application Submitted - start
  // In Progress - inProgress
  // final status - approved/rejected
  String status = 'start';
  @override
  void initState() {
    applicationStatus();
    super.initState();
  }

  applicationStatus() async {
    await Future.delayed(Duration(seconds: 5)).then((value) => setState(() {
          status = 'start';
        }));

    await Future.delayed(Duration(seconds: 5)).then((value) => setState(() {
          status = 'inProgress';
        }));
    await Future.delayed(Duration(seconds: 5)).then((value) => setState(() {
          status = 'rejected';
        }));
    await Future.delayed(Duration(seconds: 5)).then((value) => setState(() {
          status = 'approved';
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          row: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {},
          ),
        ],
      )),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                padding: EdgeInsets.only(top: 12, bottom: 12),
                decoration: ShapeDecoration(
                  color: mainColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 0.50, color: Color(0xFFD2D2D2)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Center(
                  child: Text("Priya Sharma",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Party Name",
                            style: TextStyle(
                                color: Colors.black87, fontFamily: "Roboto"),
                            children: [
                              TextSpan(
                                text: "*",
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 50,
                          child: TextField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Color.fromRGBO(28, 79, 122, 1)),
                              ),
                              border: OutlineInputBorder(),
                              labelText: "Priya Sharma",
                              hintText: 'Enter Name',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Display Name",
                            style: TextStyle(
                                color: Colors.black87, fontFamily: "Roboto"),
                            children: [
                              TextSpan(
                                text: "*",
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 50,
                          child: TextField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Color.fromRGBO(28, 79, 122, 1)),
                              ),
                              border: OutlineInputBorder(),
                              labelText: "Priya Pvt Ltd",
                              hintText: 'Enter Name',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: new AssetImage("assets/images/girl.jpg"),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  "Application Status",
                  style: headingStyle(),
                ),
              ),
              // SizedBox(height: 10),
              Container(
                // height: MediaQuery.of(context).size.height * 0.3,
                child: Column(
                  children: [
                    //* Application Submitted
                    SizedBox(
                      height: 40,
                      child: TimelineTile(
                        isFirst: true,
                        isLast: false,
                        beforeLineStyle: LineStyle(thickness: 1),
                        indicatorStyle:
                            IndicatorStyle(width: 15, color: Colors.green),
                        endChild: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Application Submitted",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontFamily: "Roboto"),
                          ),
                        ),
                      ),
                    ),
                    //* In Progress
                    SizedBox(
                      height: 40,
                      child: TimelineTile(
                        isFirst: false,
                        isLast: false,
                        beforeLineStyle: LineStyle(thickness: 1),
                        indicatorStyle: IndicatorStyle(
                            width: 15,
                            color: status == "approved"
                                ? Colors.green
                                : status == 'inProgress' || status == "rejected"
                                    ? Color.fromRGBO(28, 79, 122, 1)
                                    : Colors.grey),
                        endChild: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: RichText(
                              text: TextSpan(
                                  text: "In Progress ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: status == "approved"
                                          ? Colors.grey
                                          : status == 'inProgress'
                                              ? Color.fromRGBO(28, 79, 122, 1)
                                              : Colors.grey,
                                      fontFamily: "Roboto"),
                                  children: [
                                    status == "inProgress"
                                        ? TextSpan(
                                            text: "(in ICICI Bank)",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                                fontFamily: "Roboto"),
                                          )
                                        : TextSpan(),
                                  ]),
                            )),
                      ),
                    ),

                    //* Approved
                    SizedBox(
                      height: 40,
                      child: TimelineTile(
                        isFirst: false,
                        isLast: true,
                        beforeLineStyle: LineStyle(thickness: 1),
                        indicatorStyle: IndicatorStyle(
                          width: 15,
                          color: status == 'approved'
                              ? Colors.green
                              : status == 'rejected'
                                  ? Colors.red
                                  : Colors.grey,
                        ),
                        endChild: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            status == "approved"
                                ? "Approved"
                                : status == "rejected"
                                    ? "Rejected"
                                    : "Approved",
                            style: TextStyle(
                                fontSize: 14,
                                color: status == 'approved'
                                    ? Colors.green
                                    : status == 'rejected'
                                        ? Colors.red
                                        : Colors.grey,
                                fontFamily: "Roboto"),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 10,
              ),

              status == "approved"
                  ? Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text(
                            "Approved From (ICICI Bank)",
                            style:
                                TextStyle(fontFamily: "Roboto", fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            decoration: ShapeDecoration(
                              color: Color.fromRGBO(28, 79, 122, 1),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 0.50, color: Color(0xFFD2D2D2)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Center(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: "Loan amount Disbursed\n\n",
                                  style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.w400),
                                  children: [
                                    TextSpan(
                                      text: "50000",
                                      style: TextStyle(
                                          fontFamily: "Roboto",
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : SizedBox(),

              status == "rejected"
                  ? Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text(
                            "Rejected From (ICICI Bank)",
                            style:
                                TextStyle(fontFamily: "Roboto", fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            padding: EdgeInsets.only(
                                top: 15, bottom: 15, left: 15, right: 15),
                            decoration: ShapeDecoration(
                              color: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1.5, color: Colors.black54),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Center(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: "Reason of cancellation\n\n",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontFamily: "Roboto",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  children: [
                                    TextSpan(
                                      text:
                                          "Lorem ipsum dolor sit amet, consectetur adipisci elit, sed eiusmod tempor i",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: "Roboto",
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

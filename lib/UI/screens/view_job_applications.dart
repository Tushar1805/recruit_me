import 'dart:io';

import 'package:avestan_test/Constants/constants.dart';
import 'package:avestan_test/Constants/utils.dart';
import 'package:avestan_test/UI/widgets/normal_app_bar.dart';
import 'package:avestan_test/logic/view_applications_cubit/view_applications_cubit.dart';
import 'package:avestan_test/logic/view_applications_cubit/view_applications_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewJobApplications extends StatefulWidget {
  const ViewJobApplications({Key? key}) : super(key: key);

  @override
  State<ViewJobApplications> createState() => _ViewJobApplicationsState();
}

class _ViewJobApplicationsState extends State<ViewJobApplications> {
  static TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = BlocProvider.of<ViewApplicationsCubit>(context);

    return Scaffold(
      appBar: normalAppBar(context, "Details of Job Applications"),
      body: Container(
        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
        child: BlocBuilder<ViewApplicationsCubit, ViewApplicationsState>(
          builder: (context, state) {
            if (state is ApplicationsLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          child: Text(
                            "Total Applications: ",
                            style: normalVieWJobTextStyle(Colors.black),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          child: Text(
                            provider.applications.length.toString(),
                            style: normalVieWJobTextStyle(mainColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: height * 0.05,
                        width: width * 0.7,
                        padding: EdgeInsets.zero,
                        child: TextField(
                          controller: searchController,
                          cursorColor: mainColor,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 0.6, color: mainColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 0.6, color: mainColor),
                            ),
                            labelStyle: TextStyle(color: mainColor),
                            border: OutlineInputBorder(),
                            hintText: "Search",
                            hintStyle: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 13,
                                color: mainColor5),
                            contentPadding: EdgeInsets.only(left: 0, right: 2),
                            prefixIcon: Icon(
                              Icons.search,
                              size: 16,
                              color: mainColor5,
                            ),
                            hoverColor: mainColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 40,
                          height: height * 0.05,
                          padding: EdgeInsets.zero,
                          decoration: ShapeDecoration(
                            color: mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Icon(
                            Icons.manage_search_rounded,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Container(
                      width: width,
                      padding: EdgeInsets.zero,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: provider.applications.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 30, bottom: 10),
                                child: Card(
                                  color: Colors.blue.shade50,
                                  shadowColor: Colors.blue.shade50,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.8, color: mainColor),
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ),
                                  ),
                                  elevation: 5,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 20, right: 15, top: 10),
                                          decoration: ShapeDecoration(
                                            color: mainColor6,
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  width: 0.8, color: mainColor),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12),
                                              ),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                provider
                                                    .applications[index].name,
                                                style: TextStyle(
                                                  fontFamily: "Roboto",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                provider
                                                    .applications[index].email,
                                                style: TextStyle(
                                                  fontFamily: "Roboto",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            provider.applications[index]
                                                        .status ==
                                                    0
                                                ? statusText(
                                                    text: "Pending",
                                                    color: Colors.red,
                                                  )
                                                : provider.applications[index]
                                                            .status ==
                                                        1
                                                    ? statusText(
                                                        text: "In Progress",
                                                        color: mainColor,
                                                      )
                                                    : statusText(
                                                        text: "Approved",
                                                        color: Colors.green,
                                                      ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                              child: TextButton(
                                                onPressed: () async {
                                                  // provider
                                                  //     .emit(PDFLoadingState());
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    duration:
                                                        Duration(seconds: 2),
                                                    backgroundColor:
                                                        Colors.green,
                                                    content:
                                                        Text("Loading PDF...."),
                                                  ));
                                                  final file =
                                                      await ViewApplicationsCubit
                                                          .loadNetWork(provider
                                                              .applications[
                                                                  index]
                                                              .cv);
                                                  // provider
                                                  //     .emit(PDFLoadedState());
                                                  openPdf(context, file);
                                                },
                                                child: Text(
                                                  "View CV",
                                                  style: TextStyle(
                                                    color: mainColor,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Roboto",
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 40,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: width * 0.25,
                                child: BlocBuilder<ViewApplicationsCubit,
                                    ViewApplicationsState>(
                                  builder: (context, state) {
                                    return GestureDetector(
                                        child: Container(
                                          width: width * 0.4,
                                          height: height * 0.06,
                                          alignment: Alignment.center,
                                          decoration: ShapeDecoration(
                                            color: mainColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Text(
                                            "Take Action",
                                            style: TextStyle(
                                                fontFamily: "Roboto",
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                        ),
                                        onTap: () => {});
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  void openPdf(BuildContext context, File file) =>
      Navigator.pushNamed(context, '/pdf', arguments: {'file': file});
}

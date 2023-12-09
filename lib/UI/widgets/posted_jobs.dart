import 'package:avestan_test/Constants/constants.dart';
import 'package:avestan_test/Constants/utils.dart';
import 'package:avestan_test/logic/jobs_cubit/jobs_cubit.dart';
import 'package:avestan_test/logic/jobs_cubit/jobs_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostedJobs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = BlocProvider.of<JobsCubit>(context);
    return BlocBuilder<JobsCubit, JobsState>(
      builder: (context, state) {
        if (state is JobsPostFetchingtate) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: provider.jobs!.length,
            itemBuilder: (context, index) {
              return Container(
                width: width * 0.9,
                height: height * 0.28,
                padding:
                    EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 0.1),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(
                                      left: 20, right: 10, top: 20),
                                  child: Text(
                                    provider.jobs![index].jobId,
                                    style: subHeadingStyle(),
                                  )),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(
                                      left: 20, right: 10, top: 10),
                                  child: Text(provider.jobs![index].title,
                                      style: jobTitleTextStyle())),
                            ],
                          ),
                          Flexible(
                            child: Container(
                                alignment: Alignment.topRight,
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 20),
                                child: Text(provider.jobs![index].deadline,
                                    style: jobDeadlineTextStyle())),
                          )
                        ],
                      ),
                      Flexible(
                        child: Container(
                            alignment: Alignment.centerLeft,
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 10),
                            child: Text(provider.jobs![index].skills,
                                style: jobSimpleTextStyle())),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () async {},
                        child: Container(
                          alignment: Alignment.center,
                          width: width * 0.9,
                          height: height * 0.06,
                          decoration: ShapeDecoration(
                            color: mainColor7,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 0.50, color: Color(0xFFD2D2D2)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: (state is JobsPostSubmittingState)
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  "View Applications",
                                  style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

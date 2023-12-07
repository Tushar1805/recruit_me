import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ApplicationStatus extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final int status;
  const ApplicationStatus(
      {Key? key,
      required isFirst,
      required isLast,
      required isPast,
      required status})
      : isFirst = isFirst,
        isLast = isLast,
        isPast = isLast,
        status = status,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      lineXY: 10,
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: status == 1
          ? LineStyle(color: Colors.green)
          : status == 2
              ? LineStyle(color: Color.fromRGBO(28, 79, 122, 1))
              : LineStyle(color: Colors.black),
    );
  }
}

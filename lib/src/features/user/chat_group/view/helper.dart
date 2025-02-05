import 'dart:developer';

import 'package:flutter/material.dart';

class MyDateUtils {
  static String getFormatedTime(
    BuildContext context,
    String time,
  ) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(context);
  }

  // static String getLastTime(BuildContext context, String time) {
  //   final DateTime sent = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
  //   final DateTime now = DateTime.now();
  //   if (now.day == sent.day &&
  //       now.month == sent.month &&
  //       now.year == sent.year) {
  //     return TimeOfDay.fromDateTime(sent).format(context);
  //   }
  //   return '${sent.day} ${getMonths(sent)}';
  // }

  static String getLastTime(BuildContext context, String time) {
    log("time : $time");
    try {
      final int timestamp = int.parse(time);
      final DateTime sent = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final DateTime now = DateTime.now();

      if (now.day == sent.day &&
          now.month == sent.month &&
          now.year == sent.year) {
        return TimeOfDay.fromDateTime(sent).format(context);
      }
      return '${sent.day} ${getMonths(sent)}';
    } catch (e) {
      // Handle the exception by logging or returning a default value
      print('FormatException: Invalid time string "$time"');
      return '';
    }
  }

  // get formatted last active time of user in chat screen
  static String getLastActiveTime(BuildContext context, String lastActiven) {
    final int i = int.tryParse(lastActiven) ?? -1;
// if time i s not available then return below statement= -1) return 'Last seen not available';
    if (i == -1) return 'Last seen not available';
    DateTime time = DateTime.fromMillisecondsSinceEpoch(i);
    DateTime now = DateTime.now();
    String formattedTime = TimeOfDay.fromDateTime(time).format(context);
    if (time.day == now.day &&
        time.month == now.month &&
        time.year == now.year) {
      return 'Last seen today at ${formattedTime}';
    }
    if ((now.difference(time).inHours / 24).round() == 1) {
      return 'Last seen yesterday at $formattedTime';
    }
    String month = getMonths(time);
    return 'Last seen on ${time.day} $month on $formattedTime';
  }

  static String getMonths(DateTime date) {
    switch (date.month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Fed';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'jun';
      case 7:
        return 'jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sept';
      case 10:
        return 'oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
    }
    return 'Na';
  }
}

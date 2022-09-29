import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class TimeConversion {
  static String convertTimeStamp(Timestamp timestamp) {
    DateFormat formatter = DateFormat.yMMMMd();
    var date = formatter.format(timestamp.toDate());
    return date;
  }

  static String convertToTimeAgo(Timestamp timestamp) {
    var date = convertToDateTime(timestamp);
    var formattedTime = timeago.format(date);
    return formattedTime;
  }

  static Timestamp convertToTimeStamp(DateTime dateTime) {
    var tstamp = DateTime.now().toUtc();
    return Timestamp.fromDate(tstamp);
  }

  static DateTime convertToDateTime(Timestamp timestamp) {
    return timestamp.toDate();
  }
}

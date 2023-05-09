import 'package:cloud_firestore/cloud_firestore.dart';

class UtilsTimeApp {
  static DateTime timeStampToDateTime(Timestamp t) {
    return t.toDate();
  }

  static Timestamp dateTimeToTimeStamp(DateTime t) {
    return Timestamp.fromDate(DateTime(
      t.year,
      t.month,
      t.day,
      t.hour,
      t.minute,
    ));
  }
}

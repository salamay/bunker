import 'package:intl/intl.dart';

class MyDateUtils{

  static String dateToSingleFormat(DateTime dateTime){
    final timeNow=DateTime.fromMillisecondsSinceEpoch(dateTime.millisecondsSinceEpoch);
    String date = DateFormat('yyyy-MM-dd').format(timeNow);
    return date;
  }
  static String dateToSingleFormatWithTime(DateTime dateTime,bool isUtc){
    final timeNow=DateTime.fromMillisecondsSinceEpoch(dateTime.millisecondsSinceEpoch,isUtc: isUtc);
    String date = DateFormat('yyyy-MM-ddTHH:mm:ss.000Z').format(timeNow);
    return date;
  }
  static String dayOnly(DateTime dateTime,bool isUtc){
    final timeNow=DateTime.fromMillisecondsSinceEpoch(dateTime.millisecondsSinceEpoch,isUtc: isUtc);
    String date = DateFormat('dd/HH/mm').format(timeNow);
    return date;
  }
}
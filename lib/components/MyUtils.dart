import 'package:intl/intl.dart';

class MyUtils{
  static String changeDateFormat(String date){
    // String to date
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(date);
    final DateFormat formatter = DateFormat('dd MMM yyyy');
    final String formatted = formatter.format(tempDate);
    return formatted;
  }

  static String getDayOfWeek(String date){
    // String to date
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(date);
    final DateFormat formatter = DateFormat('EE');
    final String formatted = formatter.format(tempDate);
    return formatted;
  }

  static String getDateOfMonth(String date){
    // String to date
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(date);
    final DateFormat formatter = DateFormat('dd');
    final String formatted = formatter.format(tempDate);
    return formatted;
  }

  static String getMonthName(String date){
    // String to date
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(date);
    final DateFormat formatter = DateFormat('MMM');
    final String formatted = formatter.format(tempDate);
    return formatted;
  }

  static String changeTimeFormat(String time){
    // String to date
    DateTime tempDate = new DateFormat("HH:mm:ss").parse(time);
    final DateFormat formatter = DateFormat('hh:mm a');
    final String formatted = formatter.format(tempDate);
    return formatted;
  }
}
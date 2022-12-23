import 'package:easy_localization/easy_localization.dart';
import 'package:lottie/lottie.dart';

import '../../utils/my_lotties.dart';

dynamic isOnline(int day, int hour) {
  var moonLanding = DateTime.now();
  int weekday = moonLanding.weekday;
  int nowhour = moonLanding.hour;
  int pochtastart = 0;
  int pochtaend = int.parse("${hour.toString()[2]}${hour.toString()[3]}");
  if (hour.toString()[0] == "3") {
    pochtastart = int.parse(hour.toString()[1]);
  } else {
    pochtastart = int.parse("${hour.toString()[0]}${hour.toString()[1]}");
  }
  if (day == 8) {
    return Lottie.asset(
      MyLottie.greyoff,
    );
  } else if (hour == 7777) {
    return Lottie.asset(
      MyLottie.online,
    );
  } else if (weekday <= day) {
    if (pochtastart <= nowhour && nowhour <= pochtaend) {
      return Lottie.asset(
        MyLottie.online,
      );
    } else {
      return Lottie.asset(
        MyLottie.offline,
      );
    }
  } else {
    return Lottie.asset(
      MyLottie.offline,
    );
  }
}

String? holati(int day, int hour) {
  var moonLanding = DateTime.now();
  int weekday = moonLanding.weekday;
  int nowhour = moonLanding.hour;
  int pochtastart = 0;
  int pochtaend = int.parse("${hour.toString()[2]}${hour.toString()[3]}");
  if (hour.toString()[0] == "3") {
    pochtastart = int.parse(hour.toString()[1]);
  } else {
    pochtastart = int.parse("${hour.toString()[0]}${hour.toString()[1]}");
    print(pochtastart);
  }
  if (day == 8) {
    return "Unidentified".tr();
  } else if (hour == 7777) {
    return "Open".tr();
  } else if (weekday <= day) {
    if (pochtastart <= nowhour && nowhour <= pochtaend) {
      return "Open".tr();
    } else {
      return "Closed".tr();
    }
  } else {
    return "Closed".tr();
  }
}

String parsedate(int num) {
  String firstnum = (num~/1000).toString();
  String numstr = num.toString();
  if (num ==8888){
    return "Unidentified".tr();
  }
  else if (num ==7777){
    return "24 hour".tr();
  }
  else if (firstnum == "3"){
    return "0${numstr[1]}:00 - ${numstr[2]}${numstr[3]}:00";
  }
  //08:00 -
  else {
    return "${numstr[0]}${numstr[1]}:00 - ${numstr[2]}${numstr[3]}:00";
  }
}
String parseDay(int day){
  if(day == 8){
    return "Unidentified".tr();
  }else if(day == 7){
    return "Every day".tr();
  }else if (day == 6){
    return "Monday - Saturday".tr();
  }else if( day ==5){
    return "Monday - Friday".tr();
  }else{
    return "";
  }
}

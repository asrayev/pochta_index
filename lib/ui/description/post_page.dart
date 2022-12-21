import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:pochta_index/data/models/pochta_model.dart';
import 'package:pochta_index/utils/map_util.dart';
import 'package:pochta_index/utils/media_query.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../utils/my_colors.dart';
import '../../utils/my_lotties.dart';

class FullInfoPage extends StatefulWidget {
  PochtaModel postage;
  FullInfoPage({required this.postage, Key? key}) : super(key: key);

  @override
  State<FullInfoPage> createState() => _FullInfoPageState();
}

class _FullInfoPageState extends State<FullInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.C_0F1620,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(m_w(context) * 0.04),
          child: Column(
            children: [
              Container(
                height: m_h(context) * 0.25,
                width: m_w(context),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://sun9-76.userapi.com/impg/l-fXjFHicRl6QmJoaL8dmXVRdq3JvF9bQym-JQ/RXjAf4HdN8c.jpg?size=604x404&quality=96&sign=e3b414e1ea6b1b89a06b1ceb52adb41b&type=album"),
                        fit: BoxFit.cover)),
              ),
              Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12).w,
                    margin: const EdgeInsets.only(top: 12).r,
                    decoration:  BoxDecoration(
                      color: MyColors.C_1C2632,
                      borderRadius: BorderRadius.circular(12).r
                    ),
                    width: 400.w,
                    child: Column(
                children:  [
                  Text("Ma'lumotlar".tr(),style: TextStyle(color: Colors.white, fontSize: 14.sp),),
                  SizedBox(height: 32.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Indeksi".tr(),style: TextStyle(color: Colors.white, fontSize: 14.sp),),
                      Container(
                          width: 180.w,
                          child: Text(widget.postage.oldIndex.toString(),style: TextStyle(color: Colors.white, fontSize: 14.sp)))


                    ],
                  ),
                  SizedBox(height: 20.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Manzil".tr(),style: TextStyle(color: Colors.white, fontSize: 14.sp),),
                      Container(
                        width: 180.w,
                          child: Text(widget.postage.address.toString(),style: TextStyle(color: Colors.white, fontSize: 14.sp)))


                    ],
                  ),
                  SizedBox(height: 20.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Holati".tr(),style: TextStyle(color: Colors.white, fontSize: 14.sp),),
                      Container(
                          width: 180.w,
                          child: Row(
                            children: [
                              Text(holati(widget.postage.workDay!, widget.postage.workHour!).toString(),style: TextStyle(color: Colors.white, fontSize: 14.sp)),
                              SizedBox(width: 5.w,),
                              SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: isOnline(widget.postage.workDay!, widget.postage.workHour!),
                              )
                            ],
                          ))


                    ],
                  ),
                    SizedBox(height: 20.h,),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ish kunlari".tr(),style: TextStyle(color: Colors.white, fontSize: 14.sp),),
                      SizedBox(
                          width: 180.w,
                          child: Text(parseDay(int.parse(widget.postage.workDay.toString())),style: TextStyle(color: Colors.white, fontSize: 14.sp)))


                    ],
                  ),
                      SizedBox(height: 20.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text("Ish soati".tr(),style: TextStyle(color: Colors.white, fontSize: 14.sp),),
                        Container(
                          width: 180.w,
                          child: Text(parsedate(int.parse(widget.postage.workHour.toString())),style: TextStyle(color: Colors.white, fontSize: 14.sp)))


                    ],
                  ),
                      SizedBox(height: 20.h,),
                      Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Telefon raqami: ".tr(),style: TextStyle(color: Colors.white, fontSize: 14.sp),),
                      Container(
                          width: 180.w,
                          child: Text(widget.postage.phoneNumber.toString(),style: TextStyle(color: Colors.white, fontSize: 14.sp)))


                    ],
                  ),
                  SizedBox(height: 20.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ZoomTapAnimation(
                        child: Container(
                          height: 48.h,
                          width: 110.w,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(12).r
                          ),
                          child: const Center(
                            child: Icon(Icons.location_city),
                          ),
                        ),
                        onTap: (){
                          MapUtils.navigateTo(widget.postage.lat!, widget.postage.lon!);
                        },
                      ),
                      ZoomTapAnimation(
                        onTap: () async {
                          String number = widget.postage.phoneNumber.toString(); //set the number here
                          bool? res = await FlutterPhoneDirectCaller.callNumber(number);
                        },
                        child: Container(
                          height: 48.h,
                          width: 110.w,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12).r
                          ),
                          child: const Center(
                            child: Icon(Icons.call),
                          ),
                        ),
                      ),

                    ],
                  ),

                ],
              ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
  String parsedate(int num) {
    String firstnum = (num~/1000).toString();
    String numstr = num.toString();
    if (num ==8888){
      return "Ko'rsatilmagan";
    }
    else if (num ==7777){
      return "24 soat";
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
      return "Ko'rsatilmagan";
    }else if(day == 7){
      return "Har kuni";
    }else if (day == 6){
      return "Dushanbadan - Shanbagacha";
    }else if( day ==5){
      return "Dushanbadan -Jumagacha";
    }else{
      return "Dushanba Payshanba bo`lsa kerak";
    }
  }
  dynamic isOnline(int day, int hour) {

    var moonLanding = DateTime.now();
    int weekday = moonLanding.weekday;
    int nowhour = moonLanding.hour;
    int pochtastart = 0;
    int pochtaend = int.parse("${hour.toString()[2]}${hour.toString()[3]}");
    if (hour.toString()[0] == "3") {
      pochtastart = int.parse(hour.toString()[1]);

    }else{
      pochtastart = int.parse("${hour.toString()[0]}${hour.toString()[1]}");
    }
    if (day == 8) {
      return Lottie.asset(MyLottie.greyoff,);
    } else if (hour == 7777) {
      return Lottie.asset(MyLottie.online,);
    } else if (weekday <= day) {
      if (pochtastart <= nowhour && nowhour <= pochtaend) {
        return Lottie.asset(MyLottie.online,);
      } else {
        return Lottie.asset(MyLottie.offline,);
      }
    }else {
      return Lottie.asset(MyLottie.offline,);
    }}
}
String? holati(int day, int hour){
  var moonLanding = DateTime.now();
  int weekday = moonLanding.weekday;
  int nowhour = moonLanding.hour;
  int pochtastart = 0;
  int pochtaend = int.parse("${hour.toString()[2]}${hour.toString()[3]}");
  if(hour.toString()[0]=="3"){
    pochtastart = int.parse(hour.toString()[1]);
  }else{
    pochtastart = int.parse("${hour.toString()[0]}${hour.toString()[1]}");
    print(pochtastart);
  }
  if(day == 8){
    return "Ko'rsatilmagan";
  }else if(hour == 7777) {
    return "Ishlamoqda";
  }else if (weekday<=day){
    if (pochtastart <=nowhour && nowhour<= pochtaend){
      return "Ishlamoqda";
    }else{
      return "Yopiq";
    }
  }else {
    return "Yopiq";
  }
}

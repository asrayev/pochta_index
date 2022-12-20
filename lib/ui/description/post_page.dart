import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:pochta_index/data/models/pochta_model.dart';
import 'package:pochta_index/utils/map_util.dart';
import 'package:pochta_index/utils/media_query.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../utils/my_colors.dart';

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
                    padding: EdgeInsets.all(12),
                    margin: const EdgeInsets.only(top: 12),
                    decoration:  BoxDecoration(
                      color: MyColors.C_1C2632,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    width: 400,
                    child: Column(
                children:  [
                  Text("Ma'lumotlar".tr(),style: TextStyle(color: Colors.white),),
                  SizedBox(height: 32,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Indeksi".tr(),style: TextStyle(color: Colors.white),),
                      Container(
                          width: 180,
                          child: Text(widget.postage.oldIndex.toString(),style: TextStyle(color: Colors.white)))


                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Manzil".tr(),style: TextStyle(color: Colors.white),),
                      Container(
                        width: 180,
                          child: Text(widget.postage.address.toString(),style: TextStyle(color: Colors.white)))


                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ish kunlari".tr(),style: TextStyle(color: Colors.white),),
                      Container(
                          width: 180,
                          child: Text(parseDay(int.parse(widget.postage.workDay.toString())),style: TextStyle(color: Colors.white)))


                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ish soati".tr(),style: TextStyle(color: Colors.white),),
                      Container(
                          width: 180,
                          child: Text(parsedate(int.parse(widget.postage.workHour.toString())),style: TextStyle(color: Colors.white)))


                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Telefon raqami: ".tr(),style: TextStyle(color: Colors.white),),
                      Container(
                          width: 180,
                          child: Text(widget.postage.phoneNumber.toString(),style: TextStyle(color: Colors.white)))


                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ZoomTapAnimation(
                        child: Container(
                          height: 48,
                          width: 110,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Center(
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
                          height: 48,
                          width: 110,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: Center(
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
}

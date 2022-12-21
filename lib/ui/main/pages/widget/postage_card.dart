import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pochta_index/data/models/pochta_model.dart';
import 'package:pochta_index/data/servis/distance_service.dart';
import 'package:pochta_index/utils/my_lotties.dart';
import 'package:pochta_index/view_model/pochta_view_model.dart';
import '../../../../utils/map_util.dart';
import '../../../../utils/media_query.dart';
import '../../../../utils/my_colors.dart';
import '../../../../utils/my_icons.dart';
import '../../../../utils/my_utils.dart';
import 'package:provider/provider.dart';


class PostageCardWidget extends StatefulWidget {
  PochtaModel postage;
  PostageCardWidget({required this.postage,Key? key}) : super(key: key);

  @override
  State<PostageCardWidget> createState() => _PostageCardWidgetState();
}

class _PostageCardWidgetState extends State<PostageCardWidget> {
  @override
  Widget build(BuildContext context) {

    return Container(
      height: m_h(context) * 0.24,
      decoration: BoxDecoration(
          color: MyColors.C_1C2632,
          borderRadius: BorderRadius
              .circular(12)
              .r),
      child: Padding(
        padding: const EdgeInsets.all(12.0).r,
        child: Column(
          children: [
            SizedBox(height: 4.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                Text("Nearest post office: ".tr(), style: GoogleFonts.raleway(
                    color: MyColors.C_8A96A4, fontSize: 14.sp),),
                Text("${distance(widget.postage.lat, widget.postage.lon).toStringAsFixed(2)} km",
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),)
              ],
            ),
            SizedBox(height: 12.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.postage.oldIndex.toString(), style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp),),
                    SizedBox(width: m_w(context) * 0.005,),
                    InkWell(
                        onTap: (() async {
                          await Clipboard.setData(ClipboardData(text: widget
                              .postage.oldIndex.toString()));
                          MyUtils.getMyToast(
                              message: "Text copied to clipboard".tr());
                        }),
                        child: SvgPicture.asset(MyIcons.copy, height: 24.h,
                          width: 24.w,
                          color: MyColors.C_46AEF5,)),

                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 30.h,
                      width: 30.w,
                      // child: Lottie.asset(MyLottie.greyoff),
                      child: isOnline(
                          int.parse(widget.postage.workDay.toString()),
                          int.parse(widget.postage.workHour.toString())),
                    ),
                    SizedBox(width: 10.w,)
                  ],
                )

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 3.w,),
                    Text("Index".tr(), style: TextStyle(
                        color: MyColors.C_8A96A4, fontSize: 14.sp),),
                  ],
                ),

                Row(
                  children: [
                    Text(holati(
                int.parse(widget.postage.workDay.toString()),
        int.parse(widget.postage.workHour.toString())).toString(), style: TextStyle(
                        color: MyColors.C_8A96A4, fontSize: 14.sp),),
                    SizedBox(width: 15.w,)
                  ],
                ),
              ],
            ), // index
            SizedBox(height: m_h(context) * 0.018,),
            Row(

              children: [
                Row(
                  children: [
                    SizedBox(
                        height: m_h(context) * 0.07,
                        width: m_w(context) * 0.45,
                        child: Center(child: Text(widget.postage.address
                            .toString()
                            .length > 121 ? widget.postage.address.toString()
                            .substring(0, 122) : widget.postage.address
                            .toString(), style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp),))),


                  ],
                ),
                SizedBox(width: m_w(context) * 0.13,),
                Row(
                  children: [
                    Column(
                      children: [
                        SizedBox(height: m_h(context) * 0.045,),
                        SizedBox(
                          height: m_h(context) * 0.025,
                          width: m_w(context) * 0.30,

                          child: Text(widget.postage.phoneNumber.toString(),
                            style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp),),),
                      ],
                    )
                  ],
                ),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text("Address  ".tr(), style: TextStyle(
                        color: MyColors.C_8A96A4, fontSize: 14.sp),),
                    SizedBox(width: m_w(context) * 0.005,),
                    InkWell(
                        onTap: (() async {
                          MapUtils.navigateTo(double.parse(widget.postage.lat
                              .toString()), double.parse(widget.postage.lon
                              .toString()));
                        }),
                        child: SvgPicture.asset(
                          MyIcons.location_map, color: MyColors.C_46AEF5,
                          height: 20.h,
                          width: 20.w,)),
                  ],
                ),

                Text("Phone number    ".tr(),
                  style: TextStyle(color: MyColors.C_8A96A4, fontSize: 14.sp),)

              ],
            ) //address
          ],
        ),
      ),
    );
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
  }
  if(day == 8){
    return "Unidentified".tr();
  }else if(hour == 7777) {
    return "Open".tr();
  }else if (weekday<=day){
    if (pochtastart <=nowhour && nowhour<= pochtaend){
      return "Open".tr();
    }else{
      return "Closed".tr();
    }
  }else {
    return "Closed".tr();
  }
}





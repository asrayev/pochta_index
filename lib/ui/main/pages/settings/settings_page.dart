import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pochta_index/utils/media_query.dart';
import 'package:pochta_index/utils/my_colors.dart';
import 'package:pochta_index/utils/my_icons.dart';
import 'package:pochta_index/utils/my_lotties.dart';

import 'language_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.C_0F1620,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: m_h(context)*0.03,),
            Center(child: Text("Settings".tr(), style: GoogleFonts.lalezar(color: Colors.white, fontSize: 27.sp, fontWeight: FontWeight.w400),)),

            SizedBox(height: m_h(context)*0.03,),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: ((){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LanguagePage()));
              }),

              child: Padding(
                padding: EdgeInsets.only(left: m_w(context)*0.03, right: m_w(context)*0.03),
                child: Container(
                  width: double.infinity,
                  height: m_h(context)*0.07,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8).r,
                    color: MyColors.C_1C2632
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(right: m_w(context)*0.04, left:m_w(context)*0.03 ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Language", style: GoogleFonts.balsamiqSans(color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.w300),),
                        SvgPicture.asset(MyIcons.earth, height: 22.h, width: 22.h,color: MyColors.C_46AEF5,)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: m_h(context)*0.04,),
            Padding(
              padding: EdgeInsets.only(left: m_w(context)*0.03, right: m_w(context)*0.03),
              child: Container(
                width: double.infinity,
                height: m_h(context)*0.268,
                decoration: BoxDecoration(
                  color: MyColors.C_1C2632,
                  borderRadius: BorderRadius.circular(8).r
                ),
                child: Column(
                  children: [
                    SizedBox(height: m_h(context)*0.02,),
                    funSettings(context,"Rate this app", MyIcons.star),
                    myLine(context),
                    funSettings(context,"Share this app", MyIcons.share),
                    myLine(context),
                    funSettings(context,"Contact support", MyIcons.mail),
                    myLine(context),
                    funSettings(context,"About application", MyIcons.document),


                  ],
                ),


            )),
            SizedBox(height: m_h(context)*0.04,),
            InkWell(highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: ((){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      backgroundColor:
                      MyColors.C_1C2632,
                      title: new Text("Exit?", style: TextStyle(color: Colors.white),),
                      content: new Text("Are you sure want to exit?", style: TextStyle(color: Colors.white),),
                      actions: <Widget>[
                        TextButton(onPressed: ((){Navigator.pop(context);}), child: Text("Cancel", style: TextStyle(color: MyColors.C_8A96A4),)),
                        TextButton(onPressed: ((){exit(0);}), child: Text("Quit", style: TextStyle(color: Colors.red
                        ),)),
                      ],
                    );
                  },
                );
              }),
              child: Padding(
                padding: EdgeInsets.only(left: m_w(context)*0.03, right: m_w(context)*0.03),
                child: Container(
                  width: double.infinity,
                  height: m_h(context)*0.07,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8).r,
                      color: MyColors.C_1C2632
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(right: m_w(context)*0.04, left:m_w(context)*0.03 ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Quit", style: GoogleFonts.balsamiqSans(color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.w300),),
                        SvgPicture.asset(MyIcons.quit, height: 22.h, width: 22.h,color: MyColors.C_46AEF5,)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: m_h(context)*0.2,),
            Center(
              child: Lottie.asset(MyLottie.pochta, height: 70.h, width: 70.w),
            ),
            Center(
              child: Text("Version 1.0.0", style: TextStyle(color: MyColors.C_8A96A4, fontSize: 14.sp),),
            )
          ],
        ),
      ),
    );
  }

  Padding funSettings(BuildContext context, String Name, String icon) {
    return Padding(
                    padding: EdgeInsets.only(right: m_w(context)*0.04, left:m_w(context)*0.03 ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(Name, style: GoogleFonts.balsamiqSans(color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.w300),),
                        SvgPicture.asset(icon, height: 22.h, width: 22.h, color: MyColors.C_46AEF5,)
                      ],
                    ),
                  );
  }

  Column myLine(BuildContext context) {
    return Column(
                    children: [
                      SizedBox(height: m_h(context)*0.02,),
                      Padding(
                        padding: const EdgeInsets.only(left: 15).r,
                        child: Container(
                          height: m_h(context)*0.0001,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: m_h(context)*0.02,),
                    ],
                  );
  }
}
// alatsi
// ()=> exit(0)
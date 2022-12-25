import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:pochta_index/ui/main/pages/settings/about_us_page.dart';
import 'package:pochta_index/utils/media_query.dart';
import 'package:pochta_index/utils/my_colors.dart';
import 'package:pochta_index/utils/my_icons.dart';
import 'package:pochta_index/utils/my_lotties.dart';
import 'package:pochta_index/view_model/ads_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/map_util.dart';
import 'contributors_page.dart';
import 'language_page.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AdsViewModel>().getBannerAd();
    return Scaffold(
      backgroundColor: MyColors.C_0F1620,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: m_h(context)*0.02,),
            Center(child: Text("Settings".tr(), style: GoogleFonts.lalezar(color: Colors.white, fontSize: 27.sp, fontWeight: FontWeight.w400),)),

            SizedBox(height: m_h(context)*0.03,),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: ((){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LanguagePage(locale: context.locale.toString(),)));
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
                        Text("Language".tr(), style: GoogleFonts.balsamiqSans(color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.w300),),
                        SvgPicture.asset(MyIcons.earth, height: 22.h, width: 22.h,color: MyColors.C_46AEF5,)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: m_h(context)*0.04,),
            InkWell(
              onTap: (){
                context.read<AdsViewModel>().getFullScreenAd();
              },
              child: Padding(
                padding: EdgeInsets.only(left: m_w(context)*0.03, right: m_w(context)*0.03),
                child: Container(
                  width: double.infinity,
                  height: m_h(context)*0.335,
                  decoration: BoxDecoration(
                    color: MyColors.C_1C2632,
                    borderRadius: BorderRadius.circular(8).r
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: m_h(context)*0.02,),
                      funSettings(context,"Rate this app".tr(), MyIcons.star),
                      myLine(context),
                      InkWell(
                          onTap: ((){
                            _launchURL;
                          }),

                          child: funSettings(context,"Share this app".tr(), MyIcons.share)),
                      myLine(context),
                      InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: ((){
                            MapUtils.openSupport();
                          }),
                          child: funSettings(context,"Contact support".tr(), MyIcons.mail)),
                      myLine(context),
                      InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: ((){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUsPage()));
                          }),
                          child: funSettings(context,"About application".tr(), MyIcons.document)),
                      myLine(context),
                      InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: ((){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ContributorPage()));
                          }),
                          child: funSettings(context,"Contributors".tr(), MyIcons.creators)),


                    ],
                  ),


              )),
            ),
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
                      title: new Text("Exit?".tr(), style: TextStyle(color: Colors.white),),
                      content: new Text("Are you sure want to exit?".tr(), style: TextStyle(color: Colors.white),),
                      actions: <Widget>[
                        TextButton(onPressed: ((){Navigator.pop(context);}), child: Text("Cancel".tr(), style: TextStyle(color: MyColors.C_8A96A4),)),
                        TextButton(onPressed: ((){exit(0);}), child: Text("Quit".tr(), style: TextStyle(color: Colors.red
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
                        Text("Quit".tr(), style: GoogleFonts.balsamiqSans(color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.w300),),
                        SvgPicture.asset(MyIcons.quit, height: 22.h, width: 22.h,color: MyColors.C_46AEF5,)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: m_h(context)*0.15,),
            Center(
              child: Lottie.asset(MyLottie.pochta, height: 70.h, width: 70.w),
            ),
            Center(
              child: Text("Version 1.0.0", style: TextStyle(color: MyColors.C_8A96A4, fontSize: 14.sp),),
            )
          ],
        ),
      ),
      bottomNavigationBar: context.read<AdsViewModel>().bannerAd==null?SizedBox():Container(
        height: context.read<AdsViewModel>().bannerAd!.size.height.toDouble(),
        width: context.read<AdsViewModel>().bannerAd!.size.width.toDouble(),
        child: Container(
          height:context.read<AdsViewModel>().bannerAd!.size.height.toDouble(),
          width:context.read<AdsViewModel>().bannerAd!.size.width.toDouble(),
          child: AdWidget(
            ad: context.read<AdsViewModel>().bannerAd!,
          ),
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
  _launchURL() async {
    const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
// alatsi
// ()=> exit(0)